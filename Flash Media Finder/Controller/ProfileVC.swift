//
// profileVC.swift
//   Flash Media Finder
//
//  Created by shehab ahmed on 18/10/2021.
//

import UIKit
class ProfileVC: UIViewController {
    
    //MARK:- OutLets
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    //MARK:- LifeCycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        UserDefultManager.shared().setToMemory(true,key:"openIn")
       handelNavigationController()
       getEmailKey()
        circleImage(image: userImage, color: .white)
        addGradient()
    
        }
    //MARK:- Private Method
    private func animateName(name: String) {
        helloLabel.text = "Hello,"
        var charIndex = 0.0
         for letter in name {
                Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex,  repeats: false)
                { (timer) in
                    self.helloLabel.text?.append(letter)
                    
                }
                charIndex += 1
                }
       }
    
    private func handelProfile (email: String) {
      let useresArray = DataBaseManager.shared().arrayOfData()
        for user in useresArray {
            if user.email == email {
                animateName(name: user.name)
                nameLabel.text = user.name
                addressLabel.text = user.address
                emailLabel.text = user.email
                userImage.image = user.image.getImage()
            }
        }
        }
   private func getEmailKey () {
        if let email =  UserDefultManager.shared().getFromMemory(key: "email")as? String {
            print(email)
            handelProfile(email: email)
        } else {
            print("not Found the email on userDefult")
        }
    }
     @objc private func logout() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            UserDefultManager.shared().removeFromMemory( key: "email")
            appDelegate.goToLogin()
            }
        }
      private func handelNavigationController () {
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
       }
   }


    
    

