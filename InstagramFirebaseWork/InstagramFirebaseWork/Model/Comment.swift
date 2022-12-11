//
//  Comment.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 11.12.2022.
//

import Firebase

struct Comment {
    let uid: String
    let username: String
    let profileImageURL: String
    let timestamp: Timestamp
    let commentText: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary[FirebaseConstants.uid] as? String ?? ""
        self.username = dictionary[FirebaseConstants.username] as? String ?? ""
        self.commentText = dictionary[FirebaseConstants.comment] as? String ?? ""
        self.profileImageURL = dictionary[FirebaseConstants.profileImageURL] as? String ?? ""
        self.timestamp = dictionary[FirebaseConstants.timestamp] as? Timestamp ?? Timestamp(date: Date())
    }
}
