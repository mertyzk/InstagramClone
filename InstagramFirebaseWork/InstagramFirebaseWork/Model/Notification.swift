//
//  Notification.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 17.12.2022.
//

import Firebase

enum NotificationType: Int {
    case like
    case follow
    case comment
    
    var notificationMessage: String {
        switch self {
        case .like:
            return " liked your post."
        case .follow:
            return " starting following you."
        case .comment:
            return " commented on your post."
        }
    }
}

struct Notification {
    let uid: String
    let postImageURL: String
    let postID: String?
    let timestamp: Timestamp
    let type: NotificationType
    let id: String
    let userProfileImageURL: String
    let username: String
    
    init(dictionary: [String: Any]) {
        self.postID               = dictionary["postID"] as? String ?? ""
        self.id                   = dictionary["id"] as? String ?? ""
        self.uid                  = dictionary["uid"] as? String ?? ""
        self.postImageURL         = dictionary["postImageURL"] as? String ?? ""
        self.type                 = NotificationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
        self.timestamp            = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.userProfileImageURL  = dictionary["userProfileImageURL"] as? String ?? ""
        self.username             = dictionary["username"] as? String ?? ""
    }
}
