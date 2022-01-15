//
//  DataBaseManager.swift
//  Flash Media Finder
//
//  Created by shehab ahmed on 17/11/2021.
//
import UIKit
import SQLite
import SQLite3
class DataBaseManager {
    //MARK:- Properties
    var dataBase: Connection!
    private  static let sharedInstance = DataBaseManager()
    private let userTabel = Table("users6")
    private let searchTabel = Table("search6")
    private let id = Expression<Int>("id")
    private let user = Expression<Data>("User")
    private let cell = Expression<Data>("cell")
   
    //MARK:- Static Method
    static func shared() -> DataBaseManager {
        return DataBaseManager.sharedInstance
    }
    //MARK:- Public Method
    
    func dataBaseConnections () {
        setupConnection()
        searchHistoryConnection()
    }
    //MARK:- Creat Tabels
 func creatTabelOfUsers() {
        //        creat the tabel coloum
        let creatTabel = self.userTabel.create{
            tabel in
            tabel.column(self.id,primaryKey: true)
            tabel.column(self.user)
        }
        do {
            //            creat the tabel
            try self.dataBase.run(creatTabel)
            print("Tabel Creat")
        } catch  {
            print("Creat Tabel Error:\(error)")
        }
    }
    func creatTabelOfSearch() {
        //        creat the tabel coloum
        let creatTabel = self.searchTabel.create{
            tabel in
            tabel.column(self.cell)
            tabel.column(self.id,primaryKey: true)
        }
        do {
            //            creat the tabel
            try self.dataBase.run(creatTabel)
            print("Tabel of search Creat")
        } catch  {
            print("Creat search Tabel Error:\(error)")
        }
    }
    //MARK:- Set
    func insertUser (user:Data) {
        let insertUser = self.userTabel.insert( self.user <- user)
        do {
            try self.dataBase.run(insertUser)
            print("User inserted")
        } catch {
            print("Insert User Error:\(error)")
        }
    }
    func insertChoosenCell (cell: Data) {
        
        let lastCell = self.searchTabel.insert(self.cell <- cell )
        do {
            try self.dataBase.run(lastCell)
            print("Cell inserted")
        } catch  {
            print("Insert Cell Error:\(error)")
        }
    }
    //MARK:- Get
    func arrayOfData ()-> [User] {
        var arrUsers: [User] = []
        do {
            let users = try self.dataBase.prepare(self.userTabel)
            for user in users  {
                let sendData =  user[self.user]
                if let safeUser = coderManager.shared().decode(userData: sendData) {
                    arrUsers.append(safeUser)
                    
                }
            }
        } catch  {
            print("Show AllError:\(error)")
        }
        return arrUsers
    }
    func showAll () {
        
        do {
            let users = try self.dataBase.prepare(self.userTabel)
            for user in users  {
                let sendData =  user[self.user]
                if let safeUser = coderManager.shared().decode(userData: sendData) {
                    //                    arrUsers.append(safeUser)
                    print(user[self.id],safeUser.email)
                }
            }
        } catch  {
            print("Show AllError:\(error)")
        }
        
    }
    func arrayOfSearches () -> [Media]  {
        var searchArray: [Media] = []
        
        do {
            let searches = try self.dataBase.prepare(self.searchTabel)
            
            for search in searches {
                let sendCell = search[self.cell]
                if let safeSearch = coderManager.shared().decodeCell(cell: sendCell){
                searchArray.append(safeSearch)
                }
            }
            
        } catch  {
            print("Show last search:\(error)")
        }
        return searchArray
    }
    
//    MARK:- Private Method
    private  func setupConnection() {
          do {
              // this step we creat the file from type document and in the user files
              let doc = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
              //   giving name to the file
              let fileUrl = doc.appendingPathComponent("users").appendingPathExtension("sqlite3")
              //     try to connect with the file with the url of it
              let dataBase = try Connection (fileUrl.path)
              self.dataBase = dataBase
              print("Connection Done")
          } catch {
              print("Connection Error:\(error)")
          }
          
      }
      
    private  func searchHistoryConnection () {
          // this step we creat the file from type document and in the user files
          do { let doc = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
              //   giving name to the file
              let fileUrl = doc.appendingPathComponent("search").appendingPathExtension("sqlite3")
              //     try to connect with the file with the url of it
              let dataBase = try Connection (fileUrl.path)
              self.dataBase = dataBase
              print("Connection Done with search")
          }catch {
              print("Connection Error with search:\(error)")
          }
      }
}

















