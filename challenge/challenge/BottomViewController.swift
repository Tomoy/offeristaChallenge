//
//  BottomViewController.swift
//  challenge
//
//  Created by Tomás Ignacio Moyano on 3/8/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit

private let reuseIdentifier = "bottomCell"

class BottomViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, DataManagerDelegate, UICollectionViewDelegateFlowLayout {
    
    let endpointUrl:String = "https://s3-eu-west-1.amazonaws.com/offerista-challenge/3.json"
        
    var products = [Product]()
    var dataManager = DataManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // Register cell classes
        collectionView.register(UINib(nibName: "BottomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        
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
        let cell:BottomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BottomCollectionViewCell
        
        if let title = products[indexPath.item].title {
            cell.titleLabel.text = title
        }
        
        if let company = products[indexPath.item].company {
            cell.companyLabel.text = company
        }
        
        if let price = products[indexPath.item].price {
            cell.priceLabel.text = "€\(price)"
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
