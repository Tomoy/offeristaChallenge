//
//  Product.swift
//  challenge
//
//  Created by Tomás Ignacio Moyano on 3/8/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import ObjectMapper

class Product: Mappable {
    
    var category:String?
    var imageUrl:String?
    var title:String?
    var price:String?
    var company:String?
    
    required init?(map:Map) {
        
    }
    
    func mapping(map: Map) {
        category <- map["category"]
        imageUrl <- map["image"]
        title <- map["title"]
        price <- map["price"]
        company <- map["company"]
    }
}
