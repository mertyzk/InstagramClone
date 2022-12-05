//
//  PostViewModel.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 5.12.2022.
//

import Foundation

struct PostViewModel {
    
    private let post: Post
    
    var imageURL: URL? {
        return URL(string: post.imageURL)
    }
    
    var caption: String {
        return post.caption
    }
    
    var likes: Int {
        return post.likes
    }
    
    init(post: Post) {
        self.post = post
    }
}
