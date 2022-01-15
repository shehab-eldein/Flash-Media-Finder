//
//  AppDelegate.swift
//   Flash Media Finder
//
//  Created by shehab ahmed on 9/9/2021.
//
import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DataBaseManager.shared().dataBaseConnections()
        DataBaseManager.shared().creatTabelOfSearch()
        DataBaseManager.shared().creatTabelOfUsers()
        IQKeyboardManager.shared.enable = true
        handelRootVC()
        return true
    }
    //MARK:- Public Methods
    func goToLogin(){
        let nav = UINavigationController(rootViewController: VC.loginVC)
        self.window?.rootViewController = nav
    }
    
    //MARK:- Private Methods
    private func handelRootVC () {
        if UserDefultManager.shared().getFromMemory (key: "openIn") as? Bool == false {
            window?.rootViewController = VC.loginVC
            setNavigation(flag: 1) }
        else if  UserDefultManager.shared().getFromMemory(key: "openIn") as? Bool == true {
            window?.rootViewController = VC.MediaVC
            setNavigation(flag: 2)
        }
    }
    private func setNavigation (flag: Int) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let nav1 = UINavigationController()
        var mainView: UIViewController = VC.RegestierVC
        
        if flag == 1 {
            mainView = VC.loginVC
        }
        if flag == 2 {
            mainView = VC.MediaVC
        }
        nav1.viewControllers = [mainView]
        self.window!.rootViewController = nav1
    }
}






