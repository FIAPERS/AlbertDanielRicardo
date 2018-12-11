//
//  ViewController+CoreData.swift
//  ComprasUSA
//
//  Created by Ricardo M on 11/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController{
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
