//
//  SettingsViewController.swift
//  ComprasUSA
//
//  Created by Albert on 03/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tfDollar: UITextField!
    @IBOutlet weak var tfIof: UITextField!
    @IBOutlet weak var tfStateTaxes: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfDollar.text = tc.getFormattedValue(of: tc.dolar , withCurrency: "")
        tfIof.text = tc.getFormattedValue(of: tc.iof , withCurrency: "")
        tfStateTaxes.text = tc.getFormattedValue(of: tc.stateTax , withCurrency: "")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func setValues()  {
        tc.dolar = tc.convertToDouble(tfDollar.text!)
        tc.iof  = tc.convertToDouble(tfIof.text!)
        tc.stateTax  = tc.convertToDouble(tfStateTaxes.text!)
    }
}

extension SettingsViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        setValues()
    }
}

/*extension SettingsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return products.estados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellState", for:indexPath)
        return cell
    }
    
}

extension SettingsViewController: UITableViewDelegate{
    
}*/
