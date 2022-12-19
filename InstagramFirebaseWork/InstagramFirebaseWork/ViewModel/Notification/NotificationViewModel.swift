//
//  NotificationViewModel.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 18.12.2022.
//

import UIKit

struct NotificationViewModel {
    
    var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postId: String? {
        return notification.postID
    }
    
    var uid: String {
        return notification.uid
    }
    
    var postImageURL: URL? {
        return URL(string: notification.postImageURL)
    }
    
    var profileImageURL: URL? {
        return URL(string: notification.userProfileImageURL)
    }
    
    var notificationMessage: NSAttributedString {
        let ofSize: CGFloat = 16
        let username = notification.username
        let message  = notification.type.notificationMessage
        let attText  = NSMutableAttributedString(string: username, attributes: [.font : UIFont.boldSystemFont(ofSize: ofSize)])
        attText.append(NSAttributedString(string: message, attributes: [.font : UIFont.systemFont(ofSize: ofSize)]))
        attText.append(NSAttributedString(string: "  2m", attributes: [.font : UIFont.systemFont(ofSize: ofSize), .foregroundColor: UIColor.lightGray]))
        return attText
    }
    
    var shouldHidePostImage: Bool {
        return self.notification.type == .follow
    }
    
    var shouldHideFollowButton: Bool {
        return self.notification.type != .follow
    }
    
    var followButtonText: String {
        return notification.userIsFollowed ? "Following" : "Follow"
    }
    
    var followButtonBGColor: UIColor {
        return notification.userIsFollowed ? UIColor.white : UIColor.systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return notification.userIsFollowed ? UIColor.systemBlue : UIColor.white
    }
    
    var userIsFollowed: Bool {
        return notification.userIsFollowed ? true : false 
    }
}
