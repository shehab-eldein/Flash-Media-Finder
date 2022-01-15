//
//  Alert.swift
//   Flash Media Finder
//
//  Created by shehab ahmed on 30/10/2021.
//
import UIKit

extension UIViewController {
    
    func alert(message:String){
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func circleImage(image: UIImageView, color: UIColor) {
        image.layoutIfNeeded()
        image.layer.borderWidth = 5
        image.layer.borderColor = color.cgColor
        image.layer.cornerRadius = image.frame.width/2
    }
    func curvingTextField (textField: UITextField) {
        textField.layoutIfNeeded()
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = textField.frame.height/4
        textField.borderStyle = UITextField.BorderStyle.none
        textField.backgroundColor = UIColor.clear
        }
    func addGradient() {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.systemBlue.cgColor,UIColor.lightGray.cgColor]
        layer.frame = view.frame
        layer.locations = [0.2]
        view.layer.insertSublayer(layer, at: 0)
    }
}
