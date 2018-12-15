//
//  TaxesCalculator.swift
//  ComprasUSA
//
//  Created by Albert on 05/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//

import Foundation

class TaxesCalculator {
    
    static let shared = TaxesCalculator()
    var dolar: Double  = 3.5
    var iof: Double = 6.38
    var stateTax: Double = 7.0
    var shoppingValue: Double = 0
    let formatter = NumberFormatter()
   
    func convertToDouble(_ string : String) -> Double{
        formatter.numberStyle = .none
        return formatter.number(from: string)!.doubleValue
    }
    
    func getFormattedValue(of value: Double , withCurrency currency: String) -> String {
        formatter.numberStyle = .currency
        formatter.currencySymbol = currency
        formatter.alwaysShowsDecimalSeparator = true
        return formatter.string(for: value)!
    }
    
    
    private init(){
        formatter.usesGroupingSeparator = true
    }
    
}
