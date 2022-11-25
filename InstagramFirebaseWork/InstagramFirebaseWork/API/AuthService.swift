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
    //MARK: - Register User
    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping (Error?) -> Void) {
        ImageUploader.uploadImage(image: credentials.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if error != nil {
                    print("Error: \(error?.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else { return }
                let documentData: [String : Any] = ["email": credentials.email,
                                            "fullname": credentials.fullname,
                                            "profileImageURL": imageURL,
                                            "uid": uid,
                                            "username": credentials.username]
                COLLECTION_USERS.document(uid).setData(documentData, completion: completion)
            }
        }
    }
    
    
    //MARK: - Login
    static func login(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    
    
}
