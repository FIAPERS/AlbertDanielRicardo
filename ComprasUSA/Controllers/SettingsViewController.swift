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
    
    var stateManager = StatesManager.shared
    let config = Configuration.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfStateTaxes.text = tc.getFormattedValue(of: tc.stateTax , withCurrency: "")
        
        //utilizado para observar a notificacao de refresh para alimentar os textfields com os valores do UserDafaults
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Refresh"), object: nil, queue: nil) { (notification) in
            self.formatView()
        }
     
        loadStates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        formatView()
    }
    
    func formatView() {
        tfDollar.text = UserDefaults.standard.string(forKey: "dolar_preference")
        tfIof.text = UserDefaults.standard.string(forKey: "iof_preference")
    }
    
    
    func loadStates(){
        stateManager.loadStates(with: context)
        self.tableView.reloadData()
    }
    
    @IBAction func changedDollar(_ sender: UITextField) {
        if let dolar = Double(sender.text!) {
            config.dolar_preference = dolar
        }
    }
    
    @IBAction func changedIOF(_ sender: UITextField) {
        if let iof = Double(sender.text!) {
            config.iof_preference = iof
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func setValues()  {
        tc.dolar = tc.convertToDouble(tfDollar.text!)
        tc.iof  = tc.convertToDouble(tfIof.text!)
        tc.stateTax  = tc.convertToDouble(tfStateTaxes.text!)
    }
    @IBAction func addState(_ sender: UIButton) {
        showAlert(with: nil)
    }
    
    func showAlert(with state: States?){
        let title = state == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " estado", message: nil, preferredStyle: .alert)
        alert.addTextField { (txtStateName) in
            txtStateName.placeholder = "Nome do Estado"
            if let name = state?.stateName{
                txtStateName.text = name
            }
        }
        alert.addTextField { (txtStateTaxes) in
            txtStateTaxes.placeholder = "taxa do Estado"
            if let taxes = state?.stateTaxes{
                txtStateTaxes.text = String(taxes)
            }
        }
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            let state = state ?? States(context: self.context)
            state.stateName = alert.textFields?.first?.text
            var taxesField = alert.textFields?.last?.text
            if let taxes = Double(taxesField!) {
                state.stateTaxes = taxes
            }else{
                print("Invalid value")
            }
            do{
                try self.context.save()
                self.loadStates()
            }catch{
                print(error.localizedDescription)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
}

extension SettingsViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        setValues()
    }
}

extension SettingsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return stateManager.states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellState", for:indexPath)
        
        let state = stateManager.states[indexPath.row]
        cell.textLabel?.text = state.stateName
        cell.detailTextLabel?.text = String(state.stateTaxes)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = stateManager.states[indexPath.row]
        showAlert(with: state)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            stateManager.deleteState(index: indexPath.row, context: context)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}

extension SettingsViewController: UITableViewDelegate{
    
}
