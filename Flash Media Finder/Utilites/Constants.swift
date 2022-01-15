//
//  Constant.swift
//   Flash Media Finder
//
//  Created by shehab ahmed on 29/10/2021.
//
import UIKit
struct Regex {
    static   let email  = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let password   = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
    static  let Regexformat = "SELF MATCHES %@"
    //    1 - Password length is 8.
    //    2 - One Special Character in Password.
    }
struct  VC {
    static    let ProfileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "profileVC" ) as! ProfileVC
    static    let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginVC" ) as! LoginVC
    static let RegestierVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegeisterVC" ) as! RegeisterVC
    static let MapVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapVC" ) as! MapVC
    static  let MediaVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieTabelVc" ) as! MovieTabelVc
}
struct NetWorking {
    static let url: String = "https://itunes.apple.com/search?"
    static let mediaKey: String = "media"
    static let searchaKey: String = "term"
}

