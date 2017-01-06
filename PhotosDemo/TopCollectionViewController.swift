//
//  TopCollectionViewController.swift
//  PhotosDemo
//
//  Created by Daniel Payne on 05/01/2017.
//  Copyright © 2017 Daniel Payne. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "InstaCell"

class TopCollectionViewController: UICollectionViewController {

    var imageData: [InstaImage]?
    var selectedIndexPath: IndexPath?
    var firstLoad = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customiseCollectionViewLayout()
        self.fetchImageData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if self.firstLoad {
            self.firstLoad = false
            self.fetchImageData()
        }
        
        // Check for existence of access token. If not present, fetch it
        
        guard (UserDefaults.standard.value(forKey: "instagramAccessToken") != nil) else {
            self.performSegue(withIdentifier: "loginIdentifier", sender: self)
            self.firstLoad = true
            return
        }
    }
    
    func fetchImageData() {
        let fetcher = InstagramFetcher()
        fetcher.fetchSelfRecentImages() { imagesResponse in
            
            guard let images = imagesResponse else {
                return
            }
            
            self.imageData = images
            self.collectionView?.reloadData()
        }
    }
    
    func customiseCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        
        // Fixed item size for speed of set-up. We could of course programmatically change/calculate cell size as well
        let spacing = (width - 300) / 3
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width:150, height:75)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.footerReferenceSize = CGSize(width:width, height: 75)
        collectionView!.collectionViewLayout = layout
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
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let images = self.imageData {
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
        
        cell.configureCell(withInstaImage: instaImage)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionFooter {
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", for: indexPath)
        }
        
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "showImageIdentifier", sender: self)
    }
}
