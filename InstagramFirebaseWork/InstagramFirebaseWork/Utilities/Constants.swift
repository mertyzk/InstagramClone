//
//  Constants.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 19.11.2022.
//

import UIKit
import Firebase

//MARK: - String Constants
enum LoginRegisterStrings {
    static let emailAdress        = "E-mail address"
    static let enterPassword      = "Enter password"
    static let dontHaveAccount    = "Don't have an account? "
    static let forgotPassword     = "Forgot your password? "
    static let alreadyHaveAccount = "Already Have an Account? "
    static let signUp             = "Sign Up"
    static let getHelp            = "Get Help"
    static let login              = "Login"
    static let fullName           = "Full Name"
    static let userName           = "User Name"
}


//MARK: - Feed Images Constants
enum FeedImages {
    static let defaultImage       = UIImage(named: "defaultimage")
    static let likeUnselected     = UIImage(named: "like_unselected")?.withRenderingMode(.alwaysOriginal)
    static let comment            = UIImage(named: "comment")?.withRenderingMode(.alwaysOriginal)
    static let send2              = UIImage(named: "send2")?.withRenderingMode(.alwaysOriginal)
}


//MARK: - RegisterImages Constants
enum RegisterImages {
    static let selectPhoto        = UIImage(named: "plus_photo")
}


//MARK: - ProfileHeaderImages Constants
enum ProfileHeaderImages {
    static let gridImage          = UIImage(named: "grid")
    static let listImage          = UIImage(named: "list")
    static let bookmarkImage      = UIImage(named: "ribbon")
}


//MARK: - Firebase Constants
let COLLECTION_USERS              = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS          = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING          = Firestore.firestore().collection("following")

enum FirebaseEnum {
    static let userFollowing    = "user-following"
    static let userFollowers    = "user-followers"
}
