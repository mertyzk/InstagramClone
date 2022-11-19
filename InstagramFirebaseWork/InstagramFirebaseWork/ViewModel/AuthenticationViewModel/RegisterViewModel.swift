//
//  RegisterViewModel.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 19.11.2022.
//

import UIKit

struct RegisterViewModel: AuthenticationViewModelProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBGColor: UIColor{
        return formIsValid ? .systemPurple : #colorLiteral(red: 0.3591802418, green: 0.3747666478, blue: 0.5265965462, alpha: 1)
    }
}
