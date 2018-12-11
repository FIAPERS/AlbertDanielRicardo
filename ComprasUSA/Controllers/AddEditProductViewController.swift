//
//  AddEditProductViewController.swift
//  ComprasUSA
//
//  Created by Ricardo M on 10/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//

import UIKit

class AddEditProductViewController: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var btProductImage: UIButton!
    @IBOutlet weak var imgProductImage: UIImageView!
    
    var product: Products!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addEditProduct(_ sender: UIButton) {
        if product == nil{
            product = Products(context: context)
        }
        product.productName = txtName.text
        if let value = Double(txtValue.text!){
            product.productValue = value
        }else{
            print("Invalid value")
        }
        
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func swtCredit(_ sender: UISwitch) {
    }
    
    @IBAction func btAddState(_ sender: UIButton) {
    }
    
    @IBAction func addEditImage(_ sender: UIButton) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
