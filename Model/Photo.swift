//
//  Photo.swift
//  Shutter2
//
//  Created by Jon Bahary on 10/26/18.
//  Copyright © 2018 Jon Bahary. All rights reserved.
//

import Foundation

class Photo {
    let title: String
    let remoteURL: URL
    let photoID: String
 //   let dateTaken: Date
    
    init(title: String, photoID: String, remoteURL: URL) { // , dateTaken: Date) {
        self.title = title
        self.remoteURL = remoteURL
        self.photoID = photoID
  //      self.dateTaken = dateTaken
    }
   
    
}
extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.photoID == rhs.photoID
    }
}
