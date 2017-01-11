//
//  Product.swift
//  Fridgey
//
//  Created by Paweł Wojtkowiak on 02.01.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation
import RealmSwift

class Product {
    
    var name = ""
    var imageName: String?
    var details: String?
    var price = 0.0
    var labels: [String]?
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }    
}
