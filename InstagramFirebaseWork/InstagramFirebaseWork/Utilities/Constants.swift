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
    static let resetPassword      = "Reset Password"
    static let resetSuccessString = "We sent a link to your e-mail for reset your password"
    static let resetSuccessTitle  = "Success"
}


//MARK: - Feed Images Constants
enum FeedImages {
    static let defaultImage       = UIImage(named: "defaultimage")
    static let likeUnselected     = UIImage(named: "like_unselected")?.withRenderingMode(.alwaysOriginal)
    static let comment            = UIImage(named: "comment")?.withRenderingMode(.alwaysOriginal)
    static let send2              = UIImage(named: "send2")?.withRenderingMode(.alwaysOriginal)
    static let likeSelected       = UIImage(named: "like_selected")
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


//MARK: - SYSImages Constants
enum SYSImages {
    static let chevron            = UIImage(systemName: "chevron.left")
}


//MARK: - Firebase Constants
let COLLECTION_USERS              = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS          = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING          = Firestore.firestore().collection("following")
let COLLECTION_POSTS              = Firestore.firestore().collection("posts")
let COLLECTION_NOTIFICATIONS      = Firestore.firestore().collection("notifications")


enum FirebaseConstants {
    static let userFollowing      = "user-following"
    static let userFollowers      = "user-followers"
    static let userNotifications  = "user-notifications"
    static let ownerUid           = "ownerUid"
    static let caption            = "caption"
    static let timestamp          = "timestamp"
    static let likes              = "likes"
    static let imageURL           = "imageURL"
    static let ownerImageURL      = "ownerImageURL"
    static let ownerUsername      = "ownerUsername"
    static let email              = "email"
    static let profileImageURL    = "profileImageURL"
    static let username           = "username"
    static let fullname           = "fullname"
    static let uid                = "uid"
    static let id                 = "id"
    static let comment            = "comment"
    static let comments           = "comments"
    static let post_likes         = "post-likes"
    static let user_likes         = "user-likes"
    static let type               = "type"
    static let postid             = "postID"
    static let userProfileImage   = "userProfileImageURL"
    static let user_feed          = "user-feed"
}
