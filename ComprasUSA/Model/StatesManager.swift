//
//  StatesManager.swift
//  ComprasUSA
//
//  Created by Ricardo M on 11/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//

import CoreData

class StatesManager{
    static let shared = StatesManager()
    var states: [States] = []
    
    func loadStates(with context: NSManagedObjectContext){
        let fetchRequest: NSFetchRequest<States> = States.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "stateName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do{
            states = try context.fetch(fetchRequest)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteState(index: Int, context: NSManagedObjectContext){
        let state = states[index]
        context.delete(state)
        do{
            try context.save()
            states.remove(at: index)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    private init(){
    }
}
