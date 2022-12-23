//
//  ResetPasswordViewModel.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 23.12.2022.
//

import UIKit

struct ResetPasswordViewModel: AuthenticationViewModelProtocol {
    
    var email: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
    }
    
    var buttonBGColor: UIColor {
        return formIsValid ? .systemPurple : #colorLiteral(red: 0.3591802418, green: 0.3747666478, blue: 0.5265965462, alpha: 1)
    }
}
