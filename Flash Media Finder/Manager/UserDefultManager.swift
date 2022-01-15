//
//  UserDefultManager.swift
//   Flash Media Finder
//
//  Created by shehab ahmed on 29/10/2021.
//

import Foundation

struct UserDefultManager {
//MARK:- Properties
    private  static let sharedInstance = UserDefultManager()
    
//MARK:- Static Method
    static func shared() -> UserDefultManager {
        return UserDefultManager.sharedInstance
    }
    
//MARK:- Public Method
    func setToMemory(_ value : Any?, key: String) {
        UserDefaults.standard.set(value, forKey: key)
//        print("save in cash memory succ")
    }
    func getFromMemory (key: String) -> Any? {
        if let df = UserDefaults.standard.object(forKey: key) {
            return df
        }
        return nil
    }
    func removeFromMemory(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        print("Remove from the User Defult")
   }
    
}
