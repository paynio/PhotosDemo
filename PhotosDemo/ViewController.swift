//
//  ViewController.swift
//  PhotosDemo
//
//  Created by Dan on 27/12/2016.
//  Copyright © 2016 Daniel Payne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageData: [InstaImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check for existence of access token. If not present, fetch it
        
        guard (UserDefaults.standard.value(forKey: "instagramAccessToken") != nil) else {
            self.performSegue(withIdentifier: "loginIdentifier", sender: self)
            return
        }
        
        let fetcher = InstagramFetcher()
        fetcher.fetchSelfRecentImages() { imagesResponse in
            
            guard let images = imagesResponse else {
                return
            }
            
            self.imageData = images
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

