//
//  SearchCellViewModel.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 26.11.2022.
//

import Foundation

struct UserCellViewModel {
    
    private let user: User
    
    var profileImageURL: URL? {
        return URL(string: user.profileImageURL)
    }
    
    var username: String {
        return user.username
    }
    
    var fullname: String {
        return user.fullname
    }
    
    init(user: User){
        self.user = user
    }
}
