//
//  ProductsTableViewCell.swift
//  ComprasUSA
//
//  Created by Ricardo M on 09/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with product: Products){
        lblTitle.text = product.productName
        lblValue.text = String(product.productValue)
        if let image = product.productImage as? UIImage{
            imgProduct.image = image
        }else{
            imgProduct.image = UIImage(named: "flag")
        }
        
    }

}
