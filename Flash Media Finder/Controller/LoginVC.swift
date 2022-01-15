//
//  LoginVC.swift
//  Flash Media Finder
//
//  Created by shehab ahmed on 18/10/2021.
//

import UIKit

class LoginVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var logoLabel: UILabel!
    
    //MARK:- LifeCycle Method
    
    override func viewDidLoad() {
        circleImage(image: loginImage, color: .white)
        super.viewDidLoad()
        UserDefultManager.shared().setToMemory(false,key: "openIn")
        handelNavigationController()
                test()
        addGradient()
        animateLogo()
    }
    override func viewWillAppear(_ animated: Bool) {
        handelNavigationController()
    }
    //MARK:- Private Method
    private func animateLogo() {
        logoLabel.text = ""
        var charIndex = 0.0
        let titleText = "⚡️Flash MediaFinder"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex,  repeats: false)
            { (timer) in
                self.logoLabel.text?.append(letter)
                
            }
            charIndex += 1
            }
        }
    private func handelNavigationController () {
        title = "Login"
        navigationItem.hidesBackButton = true
    }
    
    private func goToMoviesList() {
        navigationController?.pushViewController(VC.MediaVC, animated: true)
    }
    
    private func handelData (email: String?,pass: String?) {
        var flag = 0
        let useresArray = DataBaseManager.shared().arrayOfData()
        if let safeEmail = email?.trim,!safeEmail.isEmpty,
           let safePass = pass?.trim,!safePass.isEmpty{
            for user in useresArray {
                if user.email == safeEmail {
                    flag = 1
                    if user.pass == safePass {
                        flag = 2
                    }
                }
            }
        }
        alertHandling(flag: flag)
    }
    private func alertHandling (flag: Int) {
        
        if emailTextField.text?.isEmpty == true {
            alert(message: "Please Enter Your Email")
        }
        if passTextField.text?.isEmpty == true {
            alert(message: "Please Enter Your Password")
            
        }
        switch flag {
        
        case 0:
            alert(message: "Invalid Email")
        case 1:
            alert(message: "InvalidPass")
        case 2:
            UserDefultManager.shared().setToMemory(emailTextField.text, key: "email")
            print("Email save to user defult")
            goToMoviesList()
            
        default:
            print("Stop at handel data")
        }
    }
    private func sendingTheEmail (email: String) {
        let dataDic: [String: String] = ["email": email ]
        NotificationCenter.default.post(name: Notification.Name("DataSending"),object: nil,userInfo: dataDic)
    }
    
    //MARK:- testMethod
    private  func test() {
        emailTextField.text = "shehabahmed10001@gmail.com"
        passTextField.text = "1234567@a"
    }
    
    //MARK:- Actions
    @IBAction private func loginBtnTapped(_ sender: UIButton) {
        handelData(email: emailTextField.text , pass: passTextField.text)
    }
    
    
}
