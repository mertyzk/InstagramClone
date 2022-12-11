//
//  CommentService.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 11.12.2022.
//

import Firebase

struct CommentService {
    
    //MARK: - Upload Comment
    static func uploadComment(comment: String, postID: String, user: User, completion: @escaping FirestoreCompletion) {
        let data: [String: Any] = [FirebaseConstants.uid             : user.uid,
                                   FirebaseConstants.comment         : comment,
                                   FirebaseConstants.timestamp       : Timestamp(date: Date()),
                                   FirebaseConstants.username        : user.username,
                                   FirebaseConstants.profileImageURL : user.profileImageURL]
        
        COLLECTION_POSTS.document(postID).collection(FirebaseConstants.comments).addDocument(data: data, completion: completion)
    }
    
    
    //MARK: - Fetch All Comments
    static func fetchComments() {
        
    }
    
}
