//
//  PostService.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 4.12.2022.
//

import UIKit
import Firebase

struct PostService {
    static func uploadPost(caption: String, image: UIImage, completion: @escaping FirestoreCompletion) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ImageUploader.uploadImage(image: image) { imageURL in
            let data = ["caption": caption, "timestamp": Timestamp(date: Date()), "likes": 0, "imageURL": imageURL, "ownerUid": uid] as [String: Any]
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
}
