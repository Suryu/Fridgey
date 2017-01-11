//
//  ProductItem.swift
//  Fridgey
//
//  Created by Paweł Wojtkowiak on 02.01.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingListProductEntity: Object {
    
    dynamic var name = ""
    dynamic var imageName: String?
    dynamic var amount = 0.0
    dynamic var amountUnitPrefix: String = ""
    dynamic var amountUnitSuffix: String = ""
}

class ShoppingListProduct: Product {
    
    var quantity: Quantity = Quantity()
    
    convenience init(name: String, quantity: Quantity) {
        self.init()
        self.name = name
        self.quantity = quantity
    }
    
    func serialize() -> ShoppingListProductEntity {
        let entity = ShoppingListProductEntity()
        entity.name = self.name
        entity.imageName = self.imageName
        
        let (prefix, amount, suffix) = self.quantity.toRaw()
        entity.amount = amount
        entity.amountUnitPrefix = prefix
        entity.amountUnitSuffix = suffix
        return entity
    }
    
    static func deserialize(withEntity entity: ShoppingListProductEntity) -> ShoppingListProduct {
        let product = ShoppingListProduct()
        product.name = entity.name
        product.imageName = entity.imageName
        product.quantity = Quantity(rawValue: (entity.amountUnitPrefix, entity.amount, entity.amountUnitSuffix))
        return product
    }
}
