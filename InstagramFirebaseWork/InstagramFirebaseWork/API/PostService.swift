//
//  PostService.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 4.12.2022.
//

import UIKit
import Firebase

struct PostService {
    
    //MARK: - Upload New Post
    static func uploadPost(caption: String, image: UIImage, completion: @escaping FirestoreCompletion) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ImageUploader.uploadImage(image: image) { imageURL in
            let data = ["caption": caption, "timestamp": Timestamp(date: Date()), "likes": 0, "imageURL": imageURL, "ownerUid": uid] as [String: Any]
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    
    //MARK: - Fetch Posts
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
}
