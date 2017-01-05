//
//  SingleImageViewController.swift
//  PhotosDemo
//
//  Created by Daniel Payne on 05/01/2017.
//  Copyright © 2017 Daniel Payne. All rights reserved.
//

import UIKit
import AlamofireImage

class SingleImageViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    var imageData:InstaImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let image = imageData, let imageURL = image.standardResolutionURLString {
            self.mainImageView.af_setImage(withURL: URL(string: imageURL)!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
