//
//  coderManager.swift
//   Flash Media Finder
//
//  Created by shehab ahmed on 29/10/2021.
//

import Foundation
struct coderManager {
//MARK:- Properties
        private  static let sharedInstance = coderManager()
    
//MARK:- Static Method
        static func shared() -> coderManager {
            return coderManager.sharedInstance
        }
    
//MARK:- Public Method
     func encode (user:User)-> Data? {
      let encoder = JSONEncoder()
        let codeduser:Data!
        do {
            try codeduser = encoder.encode(user)
            print("encode user done")
           return codeduser
           } catch  {
            print(error)
        }
        return nil
        
    }
     func decode (userData: Data)-> User? {
        let decoder = JSONDecoder()
        do {
             let decodedUser = try decoder.decode(User.self, from: userData)
            print("decoded Done")
           return decodedUser
        } catch  {
            print("Decode Error\(error)")
        }
        return nil
    }
    func encodeCell (cell: Media)-> Data? {
     let encoder = JSONEncoder()
       let codedCell: Data!
       do {
           try codedCell = encoder.encode(cell)
           print("encode Cell done")
          return codedCell
          } catch  {
           print(error)
       }
       return nil
       
   }
    func decodeCell (cell: Data)-> Media? {
       let decoder = JSONDecoder()
       do {
            let decodedCell = try decoder.decode(Media.self, from: cell)
           print("decoded Cell Done")
          return decodedCell
       } catch  {
           print("Decode Cell Error\(error)")
       }
       return nil
   }
}
