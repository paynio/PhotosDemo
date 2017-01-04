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
    
    let clientID = { () -> String? in
        var propListFormat = PropertyListSerialization.PropertyListFormat.xml
        var plistData: [String: AnyObject] = [:]
        let plistPath: String? = Bundle.main.path(forResource: "Creds", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propListFormat) as! [String:AnyObject]
        } catch {
            print("Error reading Creds.plist")
            return nil
        }
        
        for (key, value) in plistData {
            print("key:", key)
            print("value:", value)
        }
        
        return plistData["InstagramClientID"] as? String
    }()
    
    let accessToken = { () -> String? in
        return UserDefaults.standard.value(forKey: "instagramAccessToken") as? String
    }()
    
    func fetchRecent() {
        
        guard let token = self.accessToken else {
            return
        }
        
        
        let urlString = "https://api.instagram.com/v1/tags/nofilter/media/recent?access_token=\(token)"
        Alamofire.request(urlString).responseJSON { response in
            print(response)
        }
    }
    
    /*
    func fetchJSON() {
        print("fetchJSON")
    }
    
    func authenticateWithInstagram() {
        
        guard self.clientID != nil else {
            print("ERROR")
            return
        }

        let urlString = "https://api.instagram.com/oauth/authorize/?client_id=\(self.clientID)&redirect_uri=REDIRECT-URI&response_type=token"
        Alamofire.request(urlString).response { response in
            print(response)
        }
    }
    */
    
}
