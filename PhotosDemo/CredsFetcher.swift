//
//  CredsFetcher.swift
//  PhotosDemo
//
//  Created by Dan on 05/01/2017.
//  Copyright © 2017 Daniel Payne. All rights reserved.
//

import Foundation


enum InstaCred: String {
    case ClientID = "InstagramClientID"
    case ClientSecret = "InstagramClientSecret"
    case UserName = "InstagramUserName"
    case Password = "InstagramPassword"

}

class CredsFetcher {
    
    fileprivate var plistCreds:[String:String]?
    
    init() {
        // Set up plistCreds
        
        var propListFormat = PropertyListSerialization.PropertyListFormat.xml
        var plistData: [String: String] = [:]
        let plistPath: String? = Bundle.main.path(forResource: "Creds", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propListFormat) as! [String:String] as [String : String]
        } catch {
            print("Error reading Creds.plist")
        }
        
        for (key, value) in plistData {
            print("key:", key)
            print("value:", value)
        }
        
        plistCreds =
        
        return plistData["InstagramClientID"] as? String

        
    }
    
    func getCred(forInstaCred cred:InstaCred) -> String? {
        
        guard let creds = plistCreds else {
            return nil
        }
        
        return creds[cred.rawValue]
    }
}
