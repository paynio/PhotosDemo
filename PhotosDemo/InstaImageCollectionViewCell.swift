//
//  InstaImageCollectionViewCell.swift
//  PhotosDemo
//
//  Created by Daniel Payne on 05/01/2017.
//  Copyright © 2017 Daniel Payne. All rights reserved.
//

import UIKit
import AlamofireImage

class InstaImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descTextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    func configureCell(withInstaImage insta: InstaImage) {
        
        guard let thumb = insta.thumbnailURLString else {
            return
        }
        
        mainImageView.af_setImage(withURL:  URL(string: thumb)!)
        
        if let text = insta.descText {
            self.descTextLabel.text = text
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mainImageView.af_cancelImageRequest()
        mainImageView.layer.removeAllAnimations()
        mainImageView.image = nil
    }
}
