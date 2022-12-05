//
//  UIViewController+Ext.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 27.10.2022.
//

import JGProgressHUD
import UIKit

extension UIViewController {
    
    static let hud = JGProgressHUD(style: .dark)
    
    func setGradient(){
        let gradient                                = CAGradientLayer()
        gradient.colors                             = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations                          = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame                              = view.frame
    }
    
    
    func showLoader(_ show: Bool) {
        view.endEditing(true)
        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }
}
