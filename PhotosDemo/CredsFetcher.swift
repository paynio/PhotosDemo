//
//  CredsFetcher.swift
//  PhotosDemo
//
//  Created by Dan on 05/01/2017.
//  Copyright © 2017 Daniel Payne. All rights reserved.
//

import Foundation

let InstagramClientID = "

class CredsFetcher {
    
    fileprivate var plistCreds:[String:String]?
    
    init() {
        // Set up plistCreds
    }
    
    func getCreds(forKey key:String) -> String? {
        
        guard let creds = plistCreds else {
            return nil
        }
        
        return creds[key]
    }
    
}
