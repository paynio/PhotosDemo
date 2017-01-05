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
    
    func configureCell(with URLString: String, placeholderImage: UIImage?) {
        
        mainImageView.af_setImage(withURL:  URL(string: URLString)!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mainImageView.af_cancelImageRequest()
        mainImageView.layer.removeAllAnimations()
        mainImageView.image = nil
    }
}
