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
        
        /*
        withURL: URL(string: URLString)!,
        placeholderImage: placeholderImage,
        filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: 20.0),
        imageTransition: .crossDissolve(0.2)
        */
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mainImageView.af_cancelImageRequest()
        mainImageView.layer.removeAllAnimations()
        mainImageView.image = nil
    }
}
