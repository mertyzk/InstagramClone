//
//  AuthService.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 21.11.2022.
//

import UIKit
import FirebaseAuth

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}


struct AuthService {
    
    typealias SendPasswordResetCallback = (Error?) -> Void
    
    //MARK: - Register User
    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping (Error?) -> Void) {
        ImageUploader.uploadImage(image: credentials.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else { return }
                let documentData: [String : Any] = [FirebaseConstants.email           : credentials.email,
                                                    FirebaseConstants.fullname        : credentials.fullname,
                                                    FirebaseConstants.profileImageURL : imageURL,
                                                    FirebaseConstants.uid             : uid,
                                                    FirebaseConstants.username        : credentials.username]
                COLLECTION_USERS.document(uid).setData(documentData, completion: completion)
            }
        }
    }
    
    
    //MARK: - Login
    static func login(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    //MARK: - Reset Password
    static func resetPassword(withEmail email: String, completion: @escaping(SendPasswordResetCallback)) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
}
