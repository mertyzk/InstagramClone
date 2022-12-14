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
    static func uploadPost(caption: String, image: UIImage, user: User, completion: @escaping FirestoreCompletion) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ImageUploader.uploadImage(image: image) { imageURL in
            let data = [FirebaseConstants.caption: caption,
                        FirebaseConstants.timestamp: Timestamp(date: Date()),
                        FirebaseConstants.likes: 0,
                        FirebaseConstants.imageURL: imageURL,
                        FirebaseConstants.ownerUid: uid,
                        FirebaseConstants.ownerImageURL: user.profileImageURL,
                        FirebaseConstants.ownerUsername: user.username] as [String: Any]
            let docRef = COLLECTION_POSTS.addDocument(data: data, completion: completion)
            self.updateUserFeedAfterPost(postId: docRef.documentID)
        }
    }
    
    
    //MARK: - Fetch Posts
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.order(by: FirebaseConstants.timestamp, descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
    
    
    //MARK: - Fetch User Profile Posts
    static func fetchUserProfilePosts(forUser uid: String, completion: @escaping ([Post]) -> Void) {
        let query = COLLECTION_POSTS.whereField(FirebaseConstants.ownerUid, isEqualTo: uid)
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            var posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            posts.sort { post1, post2 in
                return post1.timestamp.seconds > post2.timestamp.seconds
            }
            completion(posts)
        }
    }
    
    
    //MARK: - Fetch Post With ID
    static func fetchPost(withPostID postID: String, completion: @escaping (Post) -> Void) {
        COLLECTION_POSTS.document(postID).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            guard let data     = snapshot.data() else { return }
            let post           = Post(postId: snapshot.documentID, dictionary: data)
            completion(post)
        }
    }
    
    
    //MARK: - Like a post
    static func likePost(post: Post, completion: @escaping FirestoreCompletion){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_POSTS.document(post.postID).updateData([FirebaseConstants.likes: post.likes + 1])
        COLLECTION_POSTS.document(post.postID).collection(FirebaseConstants.post_likes).document(uid).setData([:]) { _ in
            COLLECTION_USERS.document(uid).collection(FirebaseConstants.user_likes).document(post.postID).setData([:], completion: completion)
        }
    }
    
    
    //MARK: - Unlike a post
    static func unlikePost(post: Post, completion: @escaping FirestoreCompletion){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard post.likes > 0 else { return }
        COLLECTION_POSTS.document(post.postID).updateData([FirebaseConstants.likes: post.likes - 1])
        COLLECTION_POSTS.document(post.postID).collection(FirebaseConstants.post_likes).document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection(FirebaseConstants.user_likes).document(post.postID).delete(completion: completion)
        }
    }
    
    
    //MARK: - Check User Like the Post
    static func checkIfUserLikedPost(post: Post, completion: @escaping (Bool) -> Void) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(currentUID).collection(FirebaseConstants.user_likes).document(post.postID).getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            completion(didLike)
        }
    }
    
    
    //MARK: - Fetch Feed Posts
    static func fetchFeedPosts(completion: @escaping([Post]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var posts = [Post]()
        COLLECTION_USERS.document(uid).collection(FirebaseConstants.user_feed).getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                fetchPost(withPostID: document.documentID) { post in
                    posts.append(post)
                    posts.sort(by: { $0.timestamp.seconds > $1.timestamp.seconds })
                    // posts.sort { post1, post2 in
                    //     return post1.timestamp.seconds > post2.timestamp.seconds
                    // }
                    completion(posts)
                }
            })
        }
    }
    
    
    //MARK: - Update User Feed After Following
    static func updateUserFeedAfterFollowing(user: User, didFollow: Bool) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let query = COLLECTION_POSTS.whereField(FirebaseConstants.ownerUid, isEqualTo: user.uid)
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            let docIDs = documents.map({ $0.documentID })
            docIDs.forEach { id in
                if didFollow {
                    COLLECTION_USERS.document(uid).collection(FirebaseConstants.user_feed).document(id).setData([:])
                } else {
                    COLLECTION_USERS.document(uid).collection(FirebaseConstants.user_feed).document(id).delete()
                }
            }
        }
    }
    
    
    //MARK: - Update User Feed After Post
    private static func updateUserFeedAfterPost(postId: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWERS.document(uid).collection(FirebaseConstants.userFollowers).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            documents.forEach { document in
                COLLECTION_USERS.document(document.documentID).collection(FirebaseConstants.user_feed).document(postId).setData([:])
            }
        }
    }
}
