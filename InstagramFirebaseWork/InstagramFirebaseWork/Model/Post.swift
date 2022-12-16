//
//  Post.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 5.12.2022.
//

import Firebase

struct Post {
    let caption: String
    var likes: Int
    let ownerUid: String
    let imageURL: String
    let postID: String
    let timestamp: Timestamp
    let ownerImageURL: String
    let ownerUsername: String
    var didLike = false
    
    init(postId: String, dictionary: [String: Any]) {
        self.postID        = postId
        self.caption       = dictionary["caption"] as? String ?? ""
        self.likes         = dictionary["likes"] as? Int ?? 0
        self.imageURL      = dictionary["imageURL"] as? String ?? ""
        self.timestamp     = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerUid      = dictionary["ownerUid"] as? String ?? ""
        self.ownerImageURL = dictionary["ownerImageURL"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
    }
}
