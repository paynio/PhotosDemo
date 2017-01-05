//
//  InstagramFetcher.swift
//  PhotosDemo
//
//  Created by Daniel Payne on 31/12/2016.
//  Copyright © 2016 Daniel Payne. All rights reserved.
//

import Foundation
import Alamofire

class InstagramFetcher {
    
    let accessToken = { () -> String? in
        return UserDefaults.standard.value(forKey: "instagramAccessToken") as? String
    }()
    
    func fetchSelfRecentImages(count:Int = 10, completionHandler:@escaping ([InstaImage]?) -> ()) {
        
        guard let token = self.accessToken else {
            completionHandler(nil)
            return
        }
        
        let urlString = "https://api.instagram.com/v1/users/self/media/recent/?access_token=\(token)&count=\(count)"

        Alamofire.request(urlString).responseJSON { response in
            
            guard response.result.error == nil else {
                print(response.result.error!)
                completionHandler(nil)
                return
            }
            
            guard let json = response.result.value as? [String: Any],
            let data = json["data"] as? [[String:Any]] else {
                completionHandler(nil)
                return
            }
            
            var images:[InstaImage] = []
            
            for item in data {
                if let instaImage = InstaImage(json: item) {
                    images.append(instaImage)
                }
            }
            
            print("Items: \(images.count)")
            completionHandler(images)
        }
    }
}
