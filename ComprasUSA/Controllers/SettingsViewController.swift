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
    let alertController = UIAlertController(title: "", message:
        "", preferredStyle: UIAlertControllerStyle.alert)
    
    var stateManager = StatesManager.shared
    let config = Configuration.shared
    

    override func viewDidLoad() {
        super.viewDidLoad()
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        
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
        tc.dolar = tc.convertToDouble(tfDollar.text ?? "0.0")
        tc.iof = tc.convertToDouble(tfIof.text ?? "0.0")
        
    }
    
    
    func loadStates(){
        stateManager.loadStates(with: context)
        self.tableView.reloadData()
    }
    
    @IBAction func changedDollar(_ sender: UITextField) {
        if let dolar = Double(sender.text!) {
            config.dolar_preference = dolar
            tc.dolar = dolar
        }
    }
    
    @IBAction func changedIOF(_ sender: UITextField) {
        if let iof = Double(sender.text!) {
            config.iof_preference = iof
            tc.iof = iof
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func setValues()  {
        tc.dolar = tc.convertToDouble(tfDollar.text!)
        tc.iof  = tc.convertToDouble(tfIof.text!)
        
    }
    @IBAction func addState(_ sender: UIButton) {
        showAlert(with: nil)
    }
    
    func showAlert(with state: States?){
        let title = state == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " estado", message: nil, preferredStyle: .alert)
        alert.addTextField { (txtStateName) in
            txtStateName.placeholder = "Nome do Estado"
            txtStateName.addTarget(alert, action: #selector(alert.textChangedInInputAlert), for: .editingChanged)
            if let name = state?.stateName{
                txtStateName.text = name
            }
        }
        alert.addTextField { (txtStateTaxes) in
            txtStateTaxes.placeholder = "taxa do Estado"
            txtStateTaxes.addTarget(alert, action: #selector(alert.textChangedInInputAlert), for: .editingChanged)
            if let taxes = state?.stateTaxes{
                txtStateTaxes.text = String(taxes)
            }
        }
        
        let submitAction = (UIAlertAction(title: title, style: .default, handler: { (action) in
            
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
        submitAction.isEnabled = false
        alert.addAction(submitAction)
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

extension UIAlertController {
    
    func isValidStateName(_ name: String) -> Bool {
        return name.count > 0 && name.rangeOfCharacter(from: .whitespacesAndNewlines) == nil
    }
    
    func isValidStateTaxes(_ taxes: String) -> Bool {
        return taxes.count > 0 && taxes.rangeOfCharacter(from: .whitespacesAndNewlines) == nil && NSPredicate(format: "self matches %@", "^[0-9]{1,9999999}([,.][0-9]{1,9999999})?$").evaluate(with: taxes)
    }
    
    @objc func textChangedInInputAlert() {
        if let name = textFields?[0].text,
            let taxes = textFields?[1].text,
            let action = actions.first {
            action.isEnabled = isValidStateName(name) && isValidStateTaxes(taxes)
        }
    }
}

extension SettingsViewController: UITableViewDelegate{
    
}
