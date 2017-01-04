//
//  InstaImage.swift
//  PhotosDemo
//
//  Created by Daniel Payne on 04/01/2017.
//  Copyright © 2017 Daniel Payne. All rights reserved.
//

import Foundation

struct InstaImage {
    
    var thumbnailURLString: String?
    var standardResolutionURLString: String?
    var standardResolutionHeight: Int?
    var standardResolutionWidth: Int?
}

extension InstaImage {
    init?(imagesJson: [String: Any]) {
        guard let thumb = imagesJson["thumbnail"] as? [String:Any],
            let thumbURL = thumb["url"] as? String,
            let standard = imagesJson["standard_resolution"] as? [String:Any],
            let standardURL = standard["url"] as? String,
            let standardHeight = standard["height"] as? Int,
            let standardWidth = standard["width"] as? Int
            else {
                return nil
        }
        
        self.thumbnailURLString = thumbURL
        self.standardResolutionURLString = standardURL
        self.standardResolutionHeight = standardHeight
        self.standardResolutionWidth = standardWidth
    }
}
