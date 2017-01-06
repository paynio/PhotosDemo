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

class SingleImageViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var filterNameLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    var imageData:InstaImage?
    var filters:[CIFilter]?
    var originalImage:CIImage?
    var currentIndex = -1
    
    @IBOutlet weak var topImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.enableButtons(enabled: false)
        
        setNameLabel()
        if let caption = imageData?.descText {
            self.captionLabel.text = caption.uppercased()
        }
        self.activityView.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let image = imageData, let imageURL = image.standardResolutionURLString {
            self.topImageView.af_setImage(withURL: URL(string: imageURL)!) { res in
                
                self.originalImage = CIImage(image: self.topImageView.image!)
                self.filters = self.originalImage?.autoAdjustmentFilters()
                
                self.addExtraFilters()
                
                self.activityView.stopAnimating()
                self.activityView.isHidden = true
                
                self.enableButtons(enabled: true)
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
    }
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        self.currentIndex -= 1
        if self.currentIndex == -2 {
            self.currentIndex = (self.filters?.count)! - 1
        }
        self.enableButtons(enabled: false)
        setNameLabel()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.currentIndex += 1
        if self.currentIndex == self.filters?.count {
            self.currentIndex = -1
        }
        self.enableButtons(enabled: false)
        setNameLabel()
    }
    
    func enableButtons(enabled: Bool) {
        self.previousButton.isEnabled = enabled
        self.nextButton.isEnabled = enabled
    }
    
    func transitionTopImage(toCIImage ciImage:CIImage) {
     
        DispatchQueue.main.async {
            let toImage = UIImage(ciImage: ciImage)
            
            UIView.transition(with: self.topImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.topImageView.image = toImage
            }) { completed in
                self.enableButtons(enabled: true)
            }
        }
    }
    
    func setNameLabel() {
        if self.currentIndex == -1 {
            self.filterNameLabel.text = "NO FILTER SELECTED"
            
            if let image = self.originalImage {
                self.transitionTopImage(toCIImage: image)
            }
        }
        else {
            if let filter = self.filters?[self.currentIndex] {
                self.filterNameLabel.text = "FILTER NAME: \(filter.name)"
                
                DispatchQueue.global(qos: .userInitiated).async {
                    filter.setValue(self.originalImage, forKey: kCIInputImageKey)
                    
                    guard let outputImage = filter.outputImage else {
                        self.enableButtons(enabled: true)
                        return
                    }
                    
                    self.transitionTopImage(toCIImage: outputImage)
                    
                }
            }
        }
    }
}

