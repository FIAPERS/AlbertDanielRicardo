//
//  TaxesViewController.swift
//  ComprasUSA
//
//  Created by Albert on 03/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//

import UIKit

class TaxesViewController: UIViewController {

   
    @IBOutlet weak var lblDollar: UILabel!
    @IBOutlet weak var lblStateTaxes: UILabel!
    @IBOutlet weak var lblIof: UILabel!
    @IBOutlet weak var lblIofDescription: UILabel!
    @IBOutlet weak var SWCreditCard: UISwitch!
    @IBOutlet weak var lblReal: UILabel!
    @IBOutlet weak var lblStateTaxesDescription: UILabel!
    
    @IBAction func changeIof(_ sender: UISwitch) {
      calculateTaxes()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calculateTaxes()
    }
    
    func calculateTaxes(){
        
        lblStateTaxesDescription.text = "Imposto do estado (\(tc.getFormattedValue(of: tc.stateTax, withCurrency: ""))%)"
        
        
        lblIofDescription.text = "Iof (\(tc.getFormattedValue(of: tc.iof, withCurrency: ""))%)"
        
        
        lblDollar.text = tc.getFormattedValue(of: tc.shoppingValue, withCurrency: "US$")
        
        
        lblStateTaxes.text = tc.getFormattedValue(of: tc.stateTaxValue, withCurrency: "US$")
        
        
        lblIof.text = tc.getFormattedValue(of: tc.iofValue, withCurrency: "US$")
        
        let real = tc.calculate(creditCard: SWCreditCard.isOn)
        
        lblReal.text = tc.getFormattedValue(of: real, withCurrency: "R$")
        
        
    }
}
