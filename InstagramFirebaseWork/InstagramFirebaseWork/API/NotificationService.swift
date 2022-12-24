//
//  NotificationService.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 17.12.2022.
//

import Firebase

struct NotificationService {
    
    //MARK: - Upload a notification
    static func uploadNotification(toUid uid: String, fromUser: User, type: NotificationType, post: Post? = nil) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        guard uid != currentUID else { return }
        let document = COLLECTION_NOTIFICATIONS.document(uid).collection(FirebaseConstants.userNotifications).document()
        var data: [String: Any]  = [FirebaseConstants.timestamp: Timestamp(date: Date()),
                                    FirebaseConstants.uid: fromUser.uid,
                                    FirebaseConstants.type: type.rawValue,
                                    FirebaseConstants.id: document.documentID,
                                    FirebaseConstants.userProfileImage: fromUser.profileImageURL,
                                    FirebaseConstants.username: fromUser.username]
        if let post = post {
            data["postID"]       = post.postID
            data["postImageURL"] = post.imageURL
        }
        document.setData(data)
    }
    
    
    //MARK: - Fetch All Notifications
    static func fetchNotifications(completion: @escaping ([Notification]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let query = COLLECTION_NOTIFICATIONS.document(uid).collection(FirebaseConstants.userNotifications).order(by: FirebaseConstants.timestamp, descending: true)
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let notifications = documents.map({ Notification(dictionary: $0.data()) })
            completion(notifications)
        }
    }
}
