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
        let username = notification.username
        let message  = notification.type.notificationMessage
        let attText  = NSMutableAttributedString(string: username, attributes: [.font : UIFont.boldSystemFont(ofSize: 18)])
        attText.append(NSAttributedString(string: message, attributes: [.font : UIFont.systemFont(ofSize: 18)]))
        attText.append(NSAttributedString(string: "  2m", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.lightGray]))
        return attText
    }
}
