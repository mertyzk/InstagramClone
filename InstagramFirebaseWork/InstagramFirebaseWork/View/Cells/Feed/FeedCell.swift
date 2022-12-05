//
//  FeedCell.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 27.10.2022.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseID = "feedCell"
    var viewModel: PostViewModel? { didSet { configure() } }
    
    //MARK: - UI Elements
    private lazy var profileImageView: UIImageView = {
        let imageArea                       = UIImageView()
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
        button.addTarget(self, action: #selector(userNameButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var postImageArea: UIImageView = {
        let imageArea                       = UIImageView()
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
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    private func configureUIElements(){
        backgroundColor = .white
        addSubviewsExt(profileImageView, userNameButton, postImageArea, actionStackView, likesLabel, captionLabel, postTimeLabel)
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        
        userNameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        postImageArea.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        postImageArea.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        actionStackView.anchor(top: postImageArea.bottomAnchor, width: 120, height: 50)
        
        likesLabel.anchor(top: postLikeButton.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 8)
        
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
    }
    
    
    func configure(){
        guard let viewModel = viewModel else { return }
        captionLabel.text = viewModel.caption
        postImageArea.sd_setImage(with: viewModel.imageURL)
    }
    
    
    //MARK: - @objc Actions
    @objc func userNameButtonClicked(){
        print("Clicked at username button")
    }
}


