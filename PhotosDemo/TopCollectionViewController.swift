//
//  TopCollectionViewController.swift
//  PhotosDemo
//
//  Created by Daniel Payne on 05/01/2017.
//  Copyright © 2017 Daniel Payne. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "InstaCell"
fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

class TopCollectionViewController: UICollectionViewController {

    var imageData: [InstaImage]?
    var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

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
            self.collectionView?.reloadData()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getImageData(forIndexPath indexPath: IndexPath) -> InstaImage? {
        return self.imageData?[(indexPath as NSIndexPath).row]
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showImageIdentifier" {
            let VC = segue.destination as! SingleImageViewController
            
            if let indexPath = self.selectedIndexPath {
                VC.imageData = self.getImageData(forIndexPath: indexPath)
                self.selectedIndexPath = nil
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        if let images = self.imageData {
            print("Images.count = \(images.count)")
            return images.count
        }
        
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! InstaImageCollectionViewCell
    
        // Configure the cell
        
        guard let instaImage = self.imageData?[(indexPath as NSIndexPath).row] else {
            return cell
        }
        
        if let thumb = instaImage.thumbnailURLString {
            cell.configureCell(with: thumb, placeholderImage: nil)
        }
        
        cell.backgroundColor = UIColor.black
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "showImageIdentifier", sender: self)
    }
}
