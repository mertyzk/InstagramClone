//
//  NotificationViewModel.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 18.12.2022.
//

import UIKit

struct NotificationViewModel {
    
    private let notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
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
}
