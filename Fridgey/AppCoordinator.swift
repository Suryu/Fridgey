//
//  AppCoordinator.swift
//  Fridgey
//
//  Created by Paweł Wojtkowiak on 02.01.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import UIKit

class AppCoordinator {

    let mainNavigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.mainNavigationController = navigationController
    }
    
    func start() {
        
        let controller = setupMainViewController()
        self.mainNavigationController?.pushViewController(controller, animated: true)
        
    }
    
    func setupMainViewController() -> MainTabBarController {
        
        let controller = instantiateViewController(withIdentifier: "MainTabBarController", storyboard: "Main") as! MainTabBarController
        
        // Setup tab bar items
        let shoppingListController = instantiateViewController(withIdentifier: "ShoppingListViewController")
        let fridgesController = instantiateViewController(withIdentifier: "FridgesViewController")
        
        controller.setViewControllers([shoppingListController, fridgesController], animated: false)
        shoppingListController.tabBarItem = UITabBarItem(title: "Shopping List", image: nil, tag: 0)
        fridgesController.tabBarItem = UITabBarItem(title: "Fridges", image: nil, tag: 1)
        
        return controller
        
    }
    
    func instantiateViewController(withIdentifier identifier: String, storyboard: String = "Main") -> UIViewController {
        
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        return controller
        
    }
    
}
