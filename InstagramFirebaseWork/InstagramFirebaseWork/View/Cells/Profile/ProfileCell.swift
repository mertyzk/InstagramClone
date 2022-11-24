//
//  ProfileCell.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 22.11.2022.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseID = "profileCell"
    
    
    //MARK: - UIElements
    private lazy var postImageView: UIImageView = {
        let imageArea                       = UIImageView()
        imageArea.image                     = #imageLiteral(resourceName: "venom-7")
        imageArea.clipsToBounds             = true
        imageArea.contentMode               = .scaleAspectFill
        return imageArea
    }()
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    private func configure(){
        backgroundColor = .lightGray
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
}
