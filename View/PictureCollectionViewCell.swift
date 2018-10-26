//
//  PictureCollectionViewCell.swift
//  Shutter2
//
//  Created by Jon Bahary on 10/26/18.
//  Copyright © 2018 Jon Bahary. All rights reserved.
//

import UIKit
class PictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    func update(with image: UIImage?) {
        DispatchQueue.main.async {
            if let imageToDisplay = image {
                
                self.spinner.stopAnimating()
                self.imageView.image = imageToDisplay
                
            } else {
                self.spinner.startAnimating()
                self.imageView.image = nil
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        update(with: nil)
        self.layoutIfNeeded()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
    }
    override func prepareForReuse() {
        super.prepareForReuse()
         update(with: nil)
    }
}


