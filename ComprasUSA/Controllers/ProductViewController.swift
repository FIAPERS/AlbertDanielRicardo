//
//  ProductViewController.swift
//  ComprasUSA
//
//  Created by Ricardo M on 09/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {


    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblCreditCard: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*print("Nome do produto: \(product.name)")
        
        txtName.text = product.name
        txtEstado.text = product.state
        txtValue.text = product.value*/
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
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
