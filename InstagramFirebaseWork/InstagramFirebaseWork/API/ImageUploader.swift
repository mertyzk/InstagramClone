//
//  ImageUploader.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 21.11.2022.
//

import FirebaseStorage

struct ImageUploader {
    //MARK: - Upload Image
    static func uploadImage(image: UIImage, completed: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let fileName        = NSUUID().uuidString
        let ref             = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        ref.putData(imageData, metadata: nil) { metada, error in
            if error != nil {
                print("Failed to upload image \(error?.localizedDescription)")
                return
            }
            ref.downloadURL { url, error in
                guard let imageURL = url?.absoluteString else { return }
                completed(imageURL)
            }
        }
        
    }
}
