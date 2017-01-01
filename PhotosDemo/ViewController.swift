//
//  ViewController.swift
//  PhotosDemo
//
//  Created by Dan on 27/12/2016.
//  Copyright © 2016 Daniel Payne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fetcher = InstagramFetcher()
        fetcher.authenticateWithInstagram()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.performSegue(withIdentifier: "loginIdentifier", sender: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

