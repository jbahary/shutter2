//
//  PhotoStore.swift
//  Shutter2
//
//  Created by Jon Bahary on 10/26/18.
//  Copyright © 2018 Jon Bahary. All rights reserved.
//

import UIKit
enum ImageResult {
    case success(UIImage)
    case failure(Error)
}
enum PhotoError: Error {
    case imageCreationError
}
enum PhotosResult {
    case success([Photo])
    case failure(Error)
}
class PhotoStore {

    let imageStore = ImageStore()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    
    func fetchPhotos(completion: @escaping (PhotosResult) -> Void) {
        
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            
           let result = self.processPhotosRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    private func processPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!)
            
            
        }
        return FlickrAPI.photos(fromJSON: jsonData)
    }
   
   
    
    func fetchImage(for photo: Photo, completion: @escaping (ImageResult) -> Void) {
        let photoKey = photo.photoID
        if let image = imageStore.image(forKey: photoKey) {
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
            return
        }
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: photoKey)
            }
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
        
    }
    private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                // Couldn't create image
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(PhotoError.imageCreationError)
                }
        }
        return .success(image)
    }
}
