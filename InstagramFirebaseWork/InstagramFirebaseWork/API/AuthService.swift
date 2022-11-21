//
//  AuthService.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 21.11.2022.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    
    static func registerUser(withCredential credentials: AuthCredentials) {
        print("Credentials : \(credentials)")
    }
    
}
