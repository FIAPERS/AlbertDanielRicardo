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
    @IBOutlet weak var swtCreditCard: UISwitch!
    var product: Products!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblName.text = product.productName
        lblState.text = product.states?.stateName
        lblValue.text = String(product.productValue)
        swtCreditCard.setOn(product.creditCard, animated: true)
        
        if let image = product.productImage as? UIImage{
            imgProduct.image = image
        }else{
            imgProduct.image = UIImage(named: "product")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let vc = segue.destination as! AddEditProductViewController
        vc.product = product
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
