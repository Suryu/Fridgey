//
//  ShoppingListModel.swift
//  Fridgey
//
//  Created by Paweł Wojtkowiak on 09.01.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingListModel {
    
    var products: [ShoppingListProduct] = []
    let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func loadFromDatabase() {
        products = retrieveProductsFromDB()
        NSLog("Loaded \(products.count) products from DB")
    }
    
    func setupDemo() {
        if products.count == 0 {
            NSLog("No products in the DB, adding demo products")
            setupDemoProducts()
            loadFromDatabase()
        }
    }
    
    func setupDemoProducts() {
        
        let demoProducts = [ShoppingListProduct(name: "Ser", quantity: Quantity(30, unit: .Weight(.Decagram))),
                            ShoppingListProduct(name: "Pieczarki", quantity: Quantity(5)),
                            ShoppingListProduct(name: "Pomidory", quantity: Quantity(3)),
                            ShoppingListProduct(name: "Papryka")]
        
        try! realm.write {
            realm.add(demoProducts.map { $0.serialize() })
        }
    }
    
    func retrieveProductsFromDB() -> [ShoppingListProduct] {
        return Array(realm.objects(ShoppingListProductEntity.self)).map { ShoppingListProduct.deserialize(withEntity: $0) }
    }
}
