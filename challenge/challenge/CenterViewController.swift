//
//  CenterViewController.swift
//  challenge
//
//  Created by Tomás Ignacio Moyano on 3/8/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit

private let reuseIdentifier = "centerCell"

class CenterViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, DataManagerDelegate, UICollectionViewDelegateFlowLayout {

    let endpointUrl:String = "https://s3-eu-west-1.amazonaws.com/offerista-challenge/2.json"
    let viewTitle:String = "Interessante Angebote"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var products = [Product]()
    var dataManager = DataManager()
    
    var imageCache = [String:UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        // Register cell classes
        collectionView.register(UINib(nibName: "CenterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        
        titleLabel.text = viewTitle
        
        dataManager.delegate = self
        dataManager.getData(url: endpointUrl)

    }
    
    //Datamanager delegate method
    
    func dataWasLoaded() {
        products = dataManager.products
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CenterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CenterCollectionViewCell
        
        //Placeholder image for while it loads
        cell.imageView.image = UIImage(named: "placeholderImg.jpg")
        
        if let imageUrl = products[indexPath.item].imageUrl {
            
            //This image is already cached, dont download it again
            if let img = imageCache[imageUrl] {
                cell.imageView.image = img
            } else {
                let request: NSURLRequest = NSURLRequest(url: URL(string: imageUrl)!)
                let mainQueue = OperationQueue.main
                NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                    if error == nil {
                        // Convert the downloaded data in to a UIImage object
                        let image = UIImage(data: data!)
                        self.imageCache[imageUrl] = image
                        
                        // Update the cell
                        DispatchQueue.main.async {
                            if let cellToUpdate:CenterCollectionViewCell = collectionView.cellForItem(at: indexPath) as! CenterCollectionViewCell? {
                                if image != nil {
                                    cellToUpdate.imageView.image = image!
                                }
                                
                            }
                        }
                        collectionView.reloadItems(at: [indexPath])
                    }
                    else {
                        print("Error: \(error?.localizedDescription)")
                    }
                })
            }
        }
    
        return cell
    }
    
    //Collectionview layout delegate methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
