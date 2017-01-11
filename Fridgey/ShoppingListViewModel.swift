//
//  ShoppingListViewModel.swift
//  Fridgey
//
//  Created by Paweł Wojtkowiak on 09.01.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ShoppingListViewModel {
    
    let model = ShoppingListModel()
    let shoppingList: Variable<[ShoppingListProduct]>
    
    var searchText = "" {
        didSet {
            self.shoppingList.value = self.model.products.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
        }
    }
    
    init() {
        shoppingList = Variable(model.products)
        model.loadFromDatabase()
        model.setupDemo()
    }
    
}
