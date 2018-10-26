//
//  PictureDataSource.swift
//  Shutter2
//
//  Created by Jon Bahary on 10/26/18.
//  Copyright © 2018 Jon Bahary. All rights reserved.
//

import UIKit

class PictureDataSource: NSObject, UICollectionViewDataSource {
   
    var pictures = [Photo]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return pictures.count/3
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let identifier = "PictureCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PictureCollectionViewCell
        
        return cell
    }
}
