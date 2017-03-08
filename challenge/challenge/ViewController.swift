//
//  ViewController.swift
//  challenge
//
//  Created by Tomás Ignacio Moyano on 3/8/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DataManagerDelegate, UIScrollViewDelegate {

    let endpointUrl:String = "https://s3-eu-west-1.amazonaws.com/offerista-challenge/1.json"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var dataManager = DataManager()
    var products = [Product]()
    var imageViews = [UIImageView]()
    var xPosition:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        dataManager.delegate = self
        dataManager.getData(url: endpointUrl)

    }
    
    //Datamanager delegate method
    
    func dataWasLoaded() {
        products = dataManager.products

        let amtProducts = products.count - 1
        for i in 0...amtProducts {
            
            if let imgUrl = products[i].imageUrl {
                
                let request: NSURLRequest = NSURLRequest(url: URL(string:imgUrl)!)
                let mainQueue = OperationQueue.main
                NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                    if error == nil {
                        // Convert the downloaded data in to a UIImage object
                        let image = UIImage(data: data!)
                        let imgView = UIImageView(frame: CGRect(x:self.xPosition, y:0,width:self.scrollView.frame.width, height:self.scrollView.frame.height))
                        imgView.image = image
                        self.scrollView.addSubview(imgView)
                        self.imageViews.append(imgView)
                        
                        self.xPosition += self.scrollView.frame.width
                    }
                    else {
                        print("Error: \(error?.localizedDescription)")
                    }
                })
            }
        }

        if let category = products[0].category {
            categoryLabel.text = category
        }
        
        if let title = products[0].title {
            titleLabel.text = title
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(products.count), height: scrollView.frame.height)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

