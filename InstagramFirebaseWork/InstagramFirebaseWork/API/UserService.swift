//
//  UserService.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 25.11.2022.
//

import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
    
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        //var users = [User]()
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            let users = snapshot.documents.map { User(dictionary: $0.data()) }
            completion(users)
            
            // OR WE CAN USE BELOW CODE WITH users ARRAY AT 23. ROW
            /*snapshot.documents.forEach { document in
                let user = User(dictionary: document.data())
                users.append(user)
            }
            completion(users)*/
        }
    }
    
    
    static func follow(uid: String, completion: @escaping FirestoreCompletion) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUID).collection(FirebaseEnum.userFollowing).document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection(FirebaseEnum.userFollowers).document(currentUID).setData([:], completion: completion)
        }
    }
    
    
    static func unfollow(uid: String, completion: @escaping FirestoreCompletion) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUID).collection(FirebaseEnum.userFollowing).document(uid).delete { error in
            COLLECTION_FOLLOWERS.document(uid).collection(FirebaseEnum.userFollowers).document(currentUID).delete(completion: completion)
        }
    }
    
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping (Bool) -> Void) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUID).collection(FirebaseEnum.userFollowing).document(uid).getDocument { snapshot, error in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
    
    
    static func fetchUserStats(uid: String, completion: @escaping (UserStats) -> Void) {
        COLLECTION_FOLLOWERS.document(uid).collection(FirebaseEnum.userFollowers).getDocuments { snapshot, _ in
            let followers = snapshot?.documents.count ?? 0
            COLLECTION_FOLLOWING.document(uid).collection(FirebaseEnum.userFollowing).getDocuments { snapshot, _ in
                let following = snapshot?.documents.count ?? 0
                completion(UserStats(followers: followers, following: following))
            }
        }
    }
}
