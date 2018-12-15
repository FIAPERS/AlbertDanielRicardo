//
//  Configuration.swift
//  ComprasUSA
//
//  Created by Daniel de Castro on 12/12/18.
//  Copyright © 2018 AlbertDanielRicardo. All rights reserved.
//
import Foundation

class Configuration {
    
    enum UserDefaultsKeys: String {
        case dolar_preference = "dolar_preference"
        case iof_preference = "iof_preference"
    }
    
    let defaults = UserDefaults.standard
    static var shared: Configuration = Configuration()
    
    var dolar_preference: Double {
        get {
            return defaults.double(forKey: UserDefaultsKeys.dolar_preference.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.dolar_preference.rawValue)
        }
    }
    
    var iof_preference: Double {
        get {
            return defaults.double(forKey: UserDefaultsKeys.iof_preference.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.iof_preference.rawValue)
        }
    }
    
    
    
    private init() {
        if defaults.double(forKey:  UserDefaultsKeys.dolar_preference.rawValue) == 0 {
            defaults.set(3.2, forKey: UserDefaultsKeys.dolar_preference.rawValue)
            
        }
        
        if defaults.double(forKey:  UserDefaultsKeys.iof_preference.rawValue) == 0 {
            defaults.set(6.38, forKey: UserDefaultsKeys.iof_preference.rawValue)
            
        }
        
    }
    
}
