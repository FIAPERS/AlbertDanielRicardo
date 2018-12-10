//
//  ViewController.swift
//  ComprasUSA
//
//  Created by Albert on 03/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//

import UIKit

class ShoppingViewController: UIViewController {

    @IBOutlet weak var tfDollar: UITextField!
    @IBOutlet weak var lblRealDescription: UILabel!
    @IBOutlet weak var lblRealValor: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAmount()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tfDollar.resignFirstResponder()
        setAmount()
    }
    
    func setAmount(){
        if tfDollar.text! != ""{
            
            tc.shoppingValue = tc.convertToDouble(tfDollar.text!)
            lblRealValor.text = tc.getFormattedValue(of: tc.shoppingValue * tc.dolar, withCurrency: "R$ ")
            let dollar = tc.getFormattedValue(of: tc.shoppingValue * tc.dolar, withCurrency: "")
            lblRealDescription.text = "Valor sem impostos (dollar \(dollar))"
        
        }
    }

}

