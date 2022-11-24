//
//  ProfileHeader.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 22.11.2022.
//

import Foundation
import UIKit

class ProfileHeader: UICollectionReusableView {
    
    //MARK: - Properties
    static let reuseID = "profileHeader"
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
