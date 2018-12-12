//
//  ProductsTableViewController.swift
//  ComprasUSA
//
//  Created by Ricardo M on 09/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//

import UIKit
import CoreData

class ProductsTableViewController: UITableViewController {
    
    var fetchedResultController: NSFetchedResultsController<Products>!
    
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
    //var productsArray: [Products] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        label.text = "Sua lista esta vazia!"
        label.textAlignment = .center
        label.textColor = .gray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProducts()
    }

    func loadProducts(){
        let fetchRequest: NSFetchRequest<Products> = Products.fetchRequest()
        let sortDescritor = NSSortDescriptor(key: "productName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescritor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do{
            try fetchedResultController.performFetch()
        }catch{
            print(error.localizedDescription)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/

    //Quantidade de linhas da tabela
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = fetchedResultController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }

    //Metodo que alimenta a tabela
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProducts", for: indexPath) as! ProductsTableViewCell

        guard let products = fetchedResultController.fetchedObjects?[indexPath.row] else{
            return cell
        }
        cell.prepare(with: products)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "productSegue"{
             let vc = segue.destination as! ProductViewController
            if let products = fetchedResultController.fetchedObjects{
                vc.product = products[tableView.indexPathForSelectedRow!.row]
            }
        }

    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let vc = segue.destination as! InsertProductViewController
        vc.product = productsArray[tableView.indexPathForSelectedRow!.row]
    }*/
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let product = fetchedResultController.fetchedObjects?[indexPath.row] else{return}
            context.delete(product)
            do{
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
extension ProductsTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
             break
        default:
            tableView.reloadData()
        }
    }
}





