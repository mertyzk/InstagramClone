//
//  ProfileHeaderViewModel.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 25.11.2022.
//

import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageURL: URL? {
        return URL(string: user.profileImageURL)
    }
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var numberOfFollowers: NSAttributedString {
        return attributedTextForLabel(value: user.stats.followers, label: "Followers")
    }
    
    var numberOfFollowing: NSAttributedString {
        return attributedTextForLabel(value: user.stats.following, label: "Following")
    }
    
    var numberOfPosts: NSAttributedString {
        return attributedTextForLabel(value: 5, label: "Posts")
    }
    
    
    var followButtonBGColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    
    init(user: User) {
        self.user = user
    }
    
    
    func attributedTextForLabel(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font : UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
}
