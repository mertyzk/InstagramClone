//
//  PostViewModel.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 5.12.2022.
//

import UIKit

struct PostViewModel {
    
    var post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var imageURL: URL? {
        return URL(string: post.imageURL)
    }
    
    var profileImageURL: URL? {
        return URL(string: post.ownerImageURL)
    }
    
    var username: String {
        return post.ownerUsername
    }
    
    var caption: String {
        return post.caption
    }
    
    var likes: Int {
        return post.likes
    }
    
    var likeButtonTintColor: UIColor {
        return post.didLike ? .red : .black
    }
    
    var likeButtonImage: UIImage {
        return post.didLike ? FeedImages.likeSelected! : FeedImages.likeUnselected!
    }
    
    var likesLabelText: String {
        if post.likes != 1 {
            return "\(post.likes) likes"
        } else {
            return "\(post.likes) like"
        }
    }
    
    var timeStampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: post.timestamp.dateValue(), to: Date())
    }

}
