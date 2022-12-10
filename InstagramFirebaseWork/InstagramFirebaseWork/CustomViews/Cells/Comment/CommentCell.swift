//
//  CommentCell.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 10.12.2022.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseID = "commentCell"
    
    
    //MARK: - UI Elements
    private lazy var profileImageView: UIImageView = {
        let imageView                = UIImageView()
        imageView.contentMode        = .scaleAspectFill
        imageView.clipsToBounds      = true
        imageView.backgroundColor    = .lightGray
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private lazy var commentLabel: UILabel = {
        let label                    = UILabel()
        let attributedString         = NSMutableAttributedString(string: "testUser  ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "Test amacli bir yorum string denemesidir...asdasjdkajdajkdajsdjadjaokdjhokjfghsdkhjlfhbsdhjkfgshjkdldfgsjhkldfgsdjkhlfglsdkjfgheoşjfgudfaopghsdorfgushdfomcshdorghscedı", attributes: [.font : UIFont.systemFont(ofSize: 14)]))
        label.attributedText         = attributedString
        return label
    }()
    
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    private func configureUIElements(){
        addSubviewsExt(profileImageView, commentLabel)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        commentLabel.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
    }
}
