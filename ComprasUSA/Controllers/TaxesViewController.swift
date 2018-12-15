//
//  TaxesViewController.swift
//  ComprasUSA
//
//  Created by Albert on 03/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//

import UIKit
import CoreData

class TaxesViewController: UIViewController {


    @IBOutlet weak var lblIof: UILabel!
    @IBOutlet weak var lblReal: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculateTaxes()
    }
    
    

    func calculateTaxes(){
        
        var totalDollar: Double! = 0
        var totalReal: Double! = 0
        
        let request: NSFetchRequest<Products> = Products.fetchRequest()
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let result = try context.fetch(request)
            
            for data in result {
             
               let  valorProduto = data.productValue
               let  valorTaxaProduto = data.states?.stateTaxes ?? 0.0
               let  valorTaxaEstado  = valorProduto *  valorTaxaProduto / 100
                
                var valorCompraDollar = valorProduto + valorTaxaEstado
                
                
                if(data.creditCard){
                    
                  valorCompraDollar = valorCompraDollar + (valorCompraDollar *  tc.iof / 100)
                   
                }
                
                totalDollar = (valorCompraDollar + totalDollar)
               
                
                totalReal = totalReal + (valorCompraDollar * tc.dolar)
                
            }

        } catch {
            
            print("failed")
            
        }
        
          lblIof.text = tc.getFormattedValue(of: totalDollar, withCurrency: "US$")
          lblReal.text = tc.getFormattedValue(of: totalReal, withCurrency: "R$")
    }
}
