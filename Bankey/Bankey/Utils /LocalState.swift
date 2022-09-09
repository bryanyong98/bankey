//
//  LocalState.swift
//  Bankey
//
//  Created by Bryan Yong on 09/09/2022.
//

import Foundation

public class LocalState {
    
    private enum Keys : String {
        case hasOnboarded
    }
    
    public static var hasOnboarded : Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        set(newValue){
            UserDefaults.standard.setValue(newValue, forKey: Keys.hasOnboarded.rawValue)
        }
    }
    
    
}
