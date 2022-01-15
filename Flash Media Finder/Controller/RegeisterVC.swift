//
//  RegeisterVC.swift
//  Flash Media Finder
//
//  Created by shehab ahmed on 18/10/2021.
//
import UIKit

class RegeisterVC: UIViewController {
    //MARK:- OutLets
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var signUpImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!

    
    //MARK:- Properties
    
    var safeName: String!
    var safeEmail: String!
    var safeAdress: String!
    var safePassword: String!
    var safeImage: codableImage!
    
    //MARK:- LifeCycle Method
    override func viewWillAppear(_ animated: Bool) {
        self.logoImageView.transform = CGAffineTransform(rotationAngle: .pi/2 )
        }
    override func viewDidAppear(_ animated: Bool) {
        animateLogo()
    }
       override func viewDidLoad() {
        super.viewDidLoad()
        circleImage(image: signUpImage, color: .white)
        circleImage(image: logoImageView, color: .systemBlue)
        VC.MapVC.delegate = self
        signUpImage.image = UIImage(named: "profile")
        navigationItem.title = "Regeister"
        test()
        DataBaseManager.shared().showAll()
        addGradient()
        }
    //MARK:- Actions
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        if  passToDataBase(name: nameTextField.text, email: emailTextField.text, pass: passTextField.text, adress: addressTextField.text, img: signUpImage.image!) == true {
            goToLogin()
        }
        
    }
    @IBAction func addressBtnTapped(_ sender: UIButton) {
        present(VC.MapVC, animated: true, completion: nil)
    }
    @IBAction func imageBtnTapped(_ sender: UIButton) {
        butImage()
        print("tapped")
    }
    
}
extension  RegeisterVC {
    //MARK:- Private Methods
    private func passToDataBase(name: String?,email: String?,pass: String?,adress: String? ,img: UIImage )-> Bool {
        var flag = false
        if let  safeName = name,
           let  safeEmail = email,
           let safePassword = pass,
           let safeAdress = adress {
            let safeImage = codableImage(withImage: img)
            if AlertHandling(name: safeName, email: safeEmail, pass: safePassword, adress: safeAdress, img: safeImage) == 4 {
                let user : User = User(name: safeName, pass: safePassword, email: safeEmail, address: safeAdress, image: safeImage)
                guard let codedUser = coderManager.shared().encode(user: user) else {return true}
                DataBaseManager.shared().insertUser(user: codedUser)
                flag = true
            }
        }
        return flag
    }
    private func AlertHandling (name: String,email: String,pass: String,adress: String?,img: codableImage)-> Int {
        var flag = 0
        //        MARK:- Handel imageAlert
        if signUpImage.image == UIImage(named: "register") {
            alert(message: "Please Choose Image")
            flag += 1
        }
        //  MARK:- Handel NameAlert
        if Validator.shared().isEmptyField(String: name) {
            safeName = name
            flag += 1
        } else {
            alert(message: "Please Enter Your Name")
        }
        //        MARK:- Handel EmailAlert
        switch Validator.shared().handelEmail(email: email) {
        
        case 0:
            alert(message: "Please Enter the Email")
        case 1:
            alert(message: "Invalid Email Format")
        case 2:
            alert(message: "Please Enter diffrent Email , This Email has been taken")
        case 3:
            self.safeEmail = email
            flag += 1
            
        default:
            print( "Stop at email alert")
        }
        //        MARK:- Handel passWordAlert
        switch Validator.shared().handelPassword(pass: pass) {
        case 0:
            alert(message: "Please Enter the Password")
        case 1:
            alert(message: "Password must be atleast 8 and have one special charachter")
        case 2:
            self.safePassword = pass
            flag += 1
        default:
            print( "Stop at Password alert")
        }
        // MARK:- Handel addresAlert
        if  Validator.shared().isEmptyField(String: adress) {
            safeAdress = adress
            flag += 1
        } else {
            alert(message: "Please Enter Your Address")
        }
        return flag
        
    }
    
    private  func goToLogin(){
        let vc = UIStoryboard(name: "Main", bundle: nil)
        let loginVc = vc.instantiateViewController(identifier: "LoginVC" ) as! LoginVC
        navigationController?.pushViewController(loginVc, animated: true)
    }
    private func butImage () {
        let image = UIImagePickerController()
        image.sourceType = .photoLibrary
        image.delegate = self
        self.present(image, animated: true, completion: nil)
    }
    //    testMethod
    private  func test() {
        nameTextField.text = "shehab"
        emailTextField.text = "shehabahmed10001@gmail.com"
        passTextField.text = "1234567@a"
        addressTextField.text = "Egypt,Asyut,Asyout City,Al Gala' Bridge"
        
    }
    //MARK: - Animaions methods
    private func animateLogo() {
       flyLeft()
       UIView.animate(withDuration: 5, delay: 2, options: [.curveEaseInOut], animations: {
            self.logoImageView.transform = .identity
        }) {  _ in
            self.scaleLogo()
        }
    }
    private func scaleLogo() {
        UIView.animate(withDuration: 4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [.curveEaseInOut], animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.logoImageView.transform = .identity
        }, completion: nil)
       }
    private func flyLeft() {
        let flyLeft = CASpringAnimation(keyPath: "position.x")
        flyLeft.fromValue = -view.bounds.size.width/2
        flyLeft.toValue =    view.frame.width/2
        flyLeft.duration = 2
        flyLeft.damping = 5
        flyLeft.initialVelocity = 20
        flyLeft.fillMode = .backwards
        logoImageView.layer.add(flyLeft, forKey: nil)
    }
    
    
}
//MARK:- Delegate Method
extension RegeisterVC: mapAddressDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func sendAdress(address: String) {
        addressTextField.text = address
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage
        {
            signUpImage.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
}













