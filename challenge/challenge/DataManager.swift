//
//  DataManager.swift
//  challenge
//
//  Created by Tomás Ignacio Moyano on 3/8/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol DataManagerDelegate {
    func dataWasLoaded()
}

class DataManager: NSObject {
    
    var products = [Product]()
    var delegate:DataManagerDelegate?
    
    func getData(url:String) {
        
        let alamoManager = Alamofire.SessionManager.default
        alamoManager.session.configuration.timeoutIntervalForRequest = 20.0
        
        Alamofire.request(url).responseArray { (response:DataResponse<[Product]>) in
            
            switch response.result {
                case .success(let data):
                    self.products = data
                    
                    if self.delegate != nil {
                        self.delegate?.dataWasLoaded()
                    }
                break
                case .failure(let error):
                    print("Error: \(error)")
                break
            }
        }
    }
    
    func downloadImage(url:String) {
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent("duck.png")
            return (documentsURL, [.removePreviousFile])
        }
        
        Alamofire.download(url, to: destination).responseData { response in
            if let destinationUrl = response.destinationURL {
               // completionHandler(destinationUrl)
            }
        }
    }
}
