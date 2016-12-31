//
//  InstagramFetcher.swift
//  PhotosDemo
//
//  Created by Daniel Payne on 31/12/2016.
//  Copyright © 2016 Daniel Payne. All rights reserved.
//

import Foundation

class InstagramFetcher {
    
    let clientID = { () -> String in 
        var propListFormat = PropertyListSerialization.PropertyListFormat.xml
        var plistData: [String: AnyObject] = [:]
        let plistPath: String? = Bundle.main.path(forResource: "Creds", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propListFormat) as! [String:AnyObject]
        } catch {
            print("Error reading Creds.plist")
        }
        
        for (key, value) in plistData {
            print("key:", key)
            print("value:", value)
        }
        
        return plistData["InstagramClientID"] as! String
    }()
}
