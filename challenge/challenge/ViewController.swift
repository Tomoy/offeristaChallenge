//
//  ViewController.swift
//  challenge
//
//  Created by Tomás Ignacio Moyano on 3/8/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let endpoint1Url:String = "https://s3-eu-west-1.amazonaws.com/offerista-challenge/1.json"
    let endpoint2Url:String = "https://s3-eu-west-1.amazonaws.com/offerista-challenge/2.json"
    let endpoint3Url:String = "https://s3-eu-west-1.amazonaws.com/offerista-challenge/3.json"
    
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.getData(url: endpoint1Url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

