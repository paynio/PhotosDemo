//
//  InstaImage.swift
//  PhotosDemo
//
//  Created by Daniel Payne on 04/01/2017.
//  Copyright © 2017 Daniel Payne. All rights reserved.
//

import Foundation

struct InstaImage: CustomStringConvertible {
    
    var thumbnailURLString: String?
    var standardResolutionURLString: String?
    var standardResolutionHeight: Int?
    var standardResolutionWidth: Int?
    var instagramID: String?
    
    var description: String {
        if let thumb = thumbnailURLString, let idStr = instagramID, let height = standardResolutionHeight {
            return "ID: \(idStr)\nThumbnail: \(thumb)\nStandard Height: \(height)"
        }
        else {
            return "CHECK: Missing Key Parameters"
        }
    }
}

extension InstaImage {
    init?(json: [String: Any]) {
        
        guard let imagesJson = json["images"] as? [String:Any],
            let thumb = imagesJson["thumbnail"] as? [String:Any],
            let thumbURL = thumb["url"] as? String,
            let standard = imagesJson["standard_resolution"] as? [String:Any],
            let standardURL = standard["url"] as? String,
            let standardHeight = standard["height"] as? Int,
            let standardWidth = standard["width"] as? Int,
            let instaID = json["id"] as? String
            
            else {
                return nil
        }
        
        self.thumbnailURLString = thumbURL
        self.standardResolutionURLString = standardURL
        self.standardResolutionHeight = standardHeight
        self.standardResolutionWidth = standardWidth
        self.instagramID = instaID
    }
}
