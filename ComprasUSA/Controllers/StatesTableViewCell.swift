//
//  StatesTableViewCell.swift
//  ComprasUSA
//
//  Created by Ricardo M on 09/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//

import UIKit

class StatesTableViewCell: UITableViewCell {
    @IBOutlet weak var lblNameState: UILabel!
    @IBOutlet weak var lblTaxesState: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with state: Products){
        lblNameState.text = state.state
        lblTaxesState.text = state.value
    }

}
