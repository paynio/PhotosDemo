//
//  SingleImageViewController.swift
//  PhotosDemo
//
//  Created by Daniel Payne on 05/01/2017.
//  Copyright © 2017 Daniel Payne. All rights reserved.
//

import UIKit
import AlamofireImage
import CoreImage

class SingleImageViewController: UIViewController {

    @IBOutlet weak var filterNameLabel: UILabel!
    
    var imageData:InstaImage?
    var filters:[CIFilter]?
    var currentIndex = -1
    
    @IBOutlet weak var topImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNameLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let image = imageData, let imageURL = image.standardResolutionURLString {
            self.topImageView.af_setImage(withURL: URL(string: imageURL)!) { res in
                print("done!")
                let ciImage = CIImage(image: self.topImageView.image!)
                self.filters = ciImage?.autoAdjustmentFilters()
                print(ciImage?.autoAdjustmentFilters())
                print(self.filters?.count)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        self.currentIndex -= 1
        if self.currentIndex == -2 {
            self.currentIndex = -1
        }
        setNameLabel()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.currentIndex += 1
        if self.currentIndex == self.filters?.count {
            self.currentIndex = (self.filters?.count)! - 1
        }
        setNameLabel()
    }
    
    func setNameLabel() {
        if self.currentIndex == -1 {
            self.filterNameLabel.text = "No Filter Selected"
        }
        else {
            if let filter = self.filters?[self.currentIndex] {
                self.filterNameLabel.text = filter.name
            }
        }
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
