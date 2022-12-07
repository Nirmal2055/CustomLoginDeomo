//
//  Utilities.swift
//  CustomLoginDemo
//
//  Created by Nirmal Koirala on 18/07/2022.
//

import Foundation
import UIKit


class Utilities{



    static func styleTextField(_ textfiled:UITextField) {
    let bottomline = CALayer()
    
    bottomline.frame = CGRect(x: 0, y: textfiled.frame.height - 2, width: textfiled.frame.width, height: 2)
    
    bottomline.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
    
    textfiled.borderStyle = .none
    textfiled.layer.addSublayer(bottomline)
//    button.layer.borderWidth = 25.0
//    button.tintColor = UIColor.black
}

    static  func    styledFilledButton(_ button:UIButton){
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton){
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
static func isPasswordValid(_ password : String) -> Bool {
    do {
        let passwordRegex = try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$")
        let passwordRange = NSRange(password.startIndex..<password.endIndex, in: password)
        return passwordRegex.firstMatch(in: password, range: passwordRange) != nil
    } catch let error {
        print(error)
        return false
    }
}
}
  
