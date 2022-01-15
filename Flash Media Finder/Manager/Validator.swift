//
//  Validator.swift
//   Flash Media Finder
//
//  Created by shehab ahmed on 29/10/2021.
//
import UIKit

protocol sendingDataDelegat: class {
    func sendData (safeName: String, safeeEmail: String, safePass: String, safeAdress: String,image: codableImage)
}
class Validator:UIViewController {
    //MARK:- Properties
    private  static let sharedInstance = Validator()
    var delegate: sendingDataDelegat?
    
    //MARK:- Static Method
    static func shared() -> Validator {
        return Validator.sharedInstance
    }
    
    //    MARK:- Email Handlling
    func handelEmail(email: String?) -> Int {
        var flag = 0
        if let safeEmail = email?.trim,!safeEmail.isEmpty  {
            flag = 1
            if isValidRegex(examined: safeEmail, regex: Regex.email){
                flag = 2
                if isUniqueEmail(email: safeEmail)  {
                    flag = 3
                }
            }
        }
        return flag
    }
    private func isUniqueEmail (email: String) -> Bool {
        let arr =   DataBaseManager.shared().arrayOfData()
        var flag = true
        for user in arr {
            if user.email == email {
                print("Found the Email")
                flag = false
            } else {
                print("not found")
            }
        }
        return flag
    }
    private  func isValidRegex (examined: String, regex: String) -> Bool {
        let pred = NSPredicate(format: Regex.Regexformat, regex)
        let result = pred.evaluate(with: examined)
        return result
    }
    
    //    MARK:- Password Handlling
    func handelPassword (pass: String?) -> Int{
        var flag = 0
        if let safeEmail = pass?.trim,!safeEmail.isEmpty  {
            flag = 1
            if isValidRegex(examined: safeEmail, regex: Regex.password){
                flag = 2
            }
        }
        return flag
    }
    
    //    MARK:- Name,Adress
    func isEmptyField (String: String?) -> Bool{
        var flag = false
        
        if let safeString = String?.trim,!safeString.isEmpty{
            flag = true
           
        }
        return flag
    }
}
















