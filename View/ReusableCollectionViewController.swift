//
//  ReusableCollectionViewController.swift
//  Shutter2
//
//  Created by Jon Bahary on 10/26/18.
//  Copyright © 2018 Jon Bahary. All rights reserved.
//

import UIKit
enum FilmTypes {
    case exclusive
    case newlyAdded
    case curatorsChoice
}
class ReusableCollectionViewController: UIViewController, UICollectionViewDelegate {

     var filmType: FilmTypes = .exclusive
    var cellHeight: Int = 100
    var cellWidth: Int = 100
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    let store: PhotoStore = PhotoStore()
    let pictureDataSource = PictureDataSource()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        collectionView.dataSource = pictureDataSource
        collectionView.delegate = self
        
        let cellSize = CGSize(width:cellWidth , height:cellHeight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        layout.minimumLineSpacing = 6.0
        layout.minimumInteritemSpacing = 6.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.reloadData()
        
        store.fetchPhotos {
            (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                self.pictureDataSource.pictures = photos
                //     if let firstPhoto = photos.first {
                //          self.updateImageView(for: firstPhoto)
            //     }
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                self.pictureDataSource.pictures.removeAll()
            }
            DispatchQueue.main.async {
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var index = indexPath.row
        if filmType == .exclusive {
            index = 3 * index
        } else if filmType == .newlyAdded {
            index = 3 * index + 1
        } else {
            index = 3 * index + 2
        }
        let photo = pictureDataSource.pictures[index]
        
        store.fetchImage(for: photo) { (result) -> Void in
            guard var pictureIndex = self.pictureDataSource.pictures.index(of: photo),
                case let .success(image) = result else {
                    return
            }
            
            // let's put different pictures in each row.   will split them evenly
            if self.filmType == .exclusive {
                pictureIndex = pictureIndex/3
            } else if self.filmType == .newlyAdded {
                pictureIndex = (pictureIndex-1)/3
            } else {
                pictureIndex = (pictureIndex-2)/3
            }
            let pictureIndexPath = IndexPath(item: pictureIndex, section: 0)
            
            
            if let cell = self.collectionView.cellForItem(at: pictureIndexPath) as? PictureCollectionViewCell {
                cell.update(with: image)
            }
            
        }
    }
}
