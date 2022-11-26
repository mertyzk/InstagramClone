//
//  UserService.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 25.11.2022.
//

import Firebase

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
}
