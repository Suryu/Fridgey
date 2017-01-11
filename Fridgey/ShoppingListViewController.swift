//
//  ShoppingListViewController.swift
//  Fridgey
//
//  Created by Paweł Wojtkowiak on 02.01.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ShoppingListViewController: UIViewController {

    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = ShoppingListViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Setup RX
    
    func setupRx() {
        
        // Table view
        viewModel.shoppingList.asObservable().bindTo(productsTableView.rx.items(cellIdentifier: "ShoppingListProductCell", cellType: ShoppingListProductCell.self)) {
            row, item, cell in
            
            cell.setup(withShoppingListProduct: item)
            
            }.addDisposableTo(disposeBag)
        
        // Search bar
        searchBar.rx.text.orEmpty.throttle(1.0, scheduler: MainScheduler.instance).distinctUntilChanged().subscribe(onNext: { [unowned self] text in
            
            self.viewModel.searchText = text
            
        }).addDisposableTo(disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
