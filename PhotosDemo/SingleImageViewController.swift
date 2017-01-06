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
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var imageData:InstaImage?
    var filters:[CIFilter]?
    var originalImage:CIImage?
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
                
                self.originalImage = CIImage(image: self.topImageView.image!)
                self.filters = self.originalImage?.autoAdjustmentFilters()
                
                self.addExtraFilters()
            }
        }
    }
    
    func addExtraFilters() {
        
        let filterNames = ["CIPhotoEffectFade", "CIPhotoEffectNoir",  "CIColorInvert"]
        
        for name in filterNames {
            if let filter = CIFilter(name: name) {
                self.filters?.append(filter)
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
            self.currentIndex = (self.filters?.count)! - 1
        }
        setNameLabel()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.currentIndex += 1
        if self.currentIndex == self.filters?.count {
            self.currentIndex = -1
        }
        setNameLabel()
    }
    
    func setNameLabel() {
        if self.currentIndex == -1 {
            self.filterNameLabel.text = "No Filter Selected"
            
            if let image = self.originalImage {
                self.topImageView.image = UIImage(ciImage: image)
            }
        }
        else {
            if let filter = self.filters?[self.currentIndex] {
                self.filterNameLabel.text = filter.name
                
                filter.setValue(self.originalImage, forKey: kCIInputImageKey)
                
                
                    self.previousButton.isEnabled = false
                    self.nextButton.isEnabled = false

                    UIView.transition(with: self.topImageView,
                                      duration: 0.5,
                                      options: .transitionCrossDissolve,
                                      animations: { self.topImageView.image = UIImage(ciImage:   filter.outputImage!) },
                                      completion: { completed in
                                        self.previousButton.isEnabled = true
                                        self.nextButton.isEnabled = true
                    })
                    
                    //self.topImageView.image = UIImage(ciImage:   filter.outputImage!)
                
            }
        }
    }
}
