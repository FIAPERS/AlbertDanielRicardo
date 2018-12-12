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
    @IBOutlet weak var swtCreditCard: UISwitch!
    
    var product: Products!
    var statesManager = StatesManager.shared
    lazy var pickerView: UIPickerView = {
       let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        return pickerView
    }()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if product != nil{
            title = "Editar produto"
            btAddEdit.setTitle("Alterar", for: .normal)
            txtName.text = product.productName
            if let state = product.states, let index = statesManager.states.index(of: state){
                txtState.text = state.stateName
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
            imgProductImage.image = product.productImage as? UIImage
            swtCreditCard.setOn(product.creditCard, animated: true)
            txtValue.text = String(product.productValue)
            if product.productImage != nil{
                btProductImage.setTitle(nil, for: .normal)
            }
        }
        prepareStateTextField()
        
    }
    
    func prepareStateTextField(){
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.backgroundColor = .white
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.items = [btCancel,btFlexibleSpace,btDone]
        
        txtState.inputView = pickerView
        txtState.inputAccessoryView = toolbar
    }

    @objc func cancel(){
        txtState.resignFirstResponder()
    }
    @objc func done(){
        txtState.text = statesManager.states[pickerView.selectedRow(inComponent: 0)].stateName
        cancel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statesManager.loadStates(with: context)
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
        product.productImage = imgProductImage.image
        product.creditCard = swtCreditCard.isOn
        if !txtState.text!.isEmpty{
            let state = statesManager.states[pickerView.selectedRow(inComponent: 0)]
            product.states = state
        }
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
    
    @IBAction func addEditImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar foto", message: "De onde voce deseja escolher a foto?", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        let photosAction = UIAlertAction(title: "Album de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photosAction)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
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

extension AddEditProductViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statesManager.states.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let state = statesManager.states[row]
        return state.stateName
    }
}

extension AddEditProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imgProductImage.image = image
        btProductImage.setTitle(nil, for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
