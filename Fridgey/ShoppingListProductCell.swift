//
//  ProductCell.swift
//  Fridgey
//
//  Created by Paweł Wojtkowiak on 02.01.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import UIKit

class ShoppingListProductCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    func setup(withShoppingListProduct item: ShoppingListProduct) {
        
        productLabel.text = item.name
        productQuantityLabel.text = item.quantity.toString()
        productImage.image = UIImage(named: "image-missing")
        
        if let imageName = item.imageName {
            productImage.image = UIImage(named: imageName)
        }        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
