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
    
    
    private lazy var profileImageView: UIImageView = {
        let imageArea                       = UIImageView()
        imageArea.image                     = #imageLiteral(resourceName: "venom-7")
        imageArea.clipsToBounds             = true
        imageArea.isUserInteractionEnabled  = true
        imageArea.layer.cornerRadius        = 20
        imageArea.contentMode               = .scaleAspectFill
        return imageArea
    }()
    
    private lazy var userNameButton: UIButton = {
        let button                          = UIButton(type: .system)
        button.titleLabel?.font             = UIFont.boldSystemFont(ofSize: 13)
        button.setTitle("Hello", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var postImageArea: UIImageView = {
        let imageArea                       = UIImageView()
        imageArea.image                     = FeedImages.defaultImage
        imageArea.clipsToBounds             = true
        imageArea.isUserInteractionEnabled  = true
        imageArea.contentMode               = .scaleAspectFill
        return imageArea
    }()
    
    private lazy var postLikeButton: UIButton = {
        let button                          = UIButton(type: .system)
        button.setImage(FeedImages.likeUnselected, for: .normal)
        button.isUserInteractionEnabled     = true
        return button
    }()
    
    private lazy var postCommentButton: UIButton = {
        let button                          = UIButton(type: .system)
        button.setImage(FeedImages.comment, for: .normal)
        button.isUserInteractionEnabled     = true
        return button
    }()
    
    private lazy var postDMButton: UIButton = {
        let button                          = UIButton(type: .system)
        button.setImage(FeedImages.send2, for: .normal)
        button.isUserInteractionEnabled     = true
        return button
    }()
    
    private lazy var likesLabel: UILabel = {
        let label                           = UILabel()
        label.text                          = "2 like"
        label.font                          = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    private lazy var captionLabel: UILabel = {
        let label                           = UILabel()
        label.text                          = "Test caption for now"
        label.font                          = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var postTimeLabel: UILabel = {
        let label                           = UILabel()
        label.text                          = "3 days ago"
        label.font                          = UIFont.systemFont(ofSize: 12)
        label.textColor                     = .lightGray
        return label
    }()
    
    private lazy var actionStackView: UIStackView = {
        let stackView                       = UIStackView(arrangedSubviews: [postLikeButton, postCommentButton, postDMButton])
        stackView.axis                      = .horizontal
        stackView.distribution              = .fillEqually
        return stackView
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
        

    }
    
    
    //MARK: - addTarget @objc Functions
    

    
}
