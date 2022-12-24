//
//  FeedCell.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 27.10.2022.
//

import UIKit

protocol FeedCellProtocolDelegate: AnyObject {
    func cell(_ cell: FeedCell, showCommentsFor post: Post)
    func cell(_ cell: FeedCell, didLike post: Post)
    func cell(_ cell: FeedCell, wantsToShowProfileFor uid: String)
}

class FeedCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseID = "feedCell"
    var viewModel: PostViewModel? { didSet { configure() } }
    weak var delegate: FeedCellProtocolDelegate?
    
    
    //MARK: - UI Elements
    private lazy var profileImageView: UIImageView = {
        let imageArea                       = UIImageView()
        imageArea.clipsToBounds             = true
        imageArea.isUserInteractionEnabled  = true
        imageArea.layer.cornerRadius        = 20
        imageArea.contentMode               = .scaleAspectFill
        imageArea.backgroundColor           = .lightGray
        let tapGestureRecognizer            = UIGestureRecognizer(target: self, action: #selector(areaOfGoToUserProfile))
        imageArea.addGestureRecognizer(tapGestureRecognizer)
        return imageArea
    }()
    
    private lazy var userNameButton: UIButton = {
        let button                          = UIButton(type: .system)
        button.titleLabel?.font             = UIFont.boldSystemFont(ofSize: 13)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(areaOfGoToUserProfile), for: .touchUpInside)
        return button
    }()
    
    private lazy var postImageArea: UIImageView = {
        let imageArea                       = UIImageView()
        imageArea.clipsToBounds             = true
        imageArea.isUserInteractionEnabled  = true
        imageArea.contentMode               = .scaleAspectFill
        return imageArea
    }()
    
    lazy var postLikeButton: UIButton = {
        let button                          = UIButton(type: .system)
        button.setImage(FeedImages.likeUnselected, for: .normal)
        button.isUserInteractionEnabled     = true
        button.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var postCommentButton: UIButton = {
        let button                          = UIButton(type: .system)
        button.setImage(FeedImages.comment, for: .normal)
        button.isUserInteractionEnabled     = true
        button.addTarget(self, action: #selector(commentsClicked), for: .touchUpInside)
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
        guard let viewModel      = viewModel else { return }
        captionLabel.text        = viewModel.caption
        likesLabel.text          = viewModel.likesLabelText
        postLikeButton.tintColor = viewModel.likeButtonTintColor
        postTimeLabel.text       = viewModel.timeStampString
        postLikeButton.setImage(viewModel.likeButtonImage, for: .normal)
        userNameButton.setTitle(viewModel.username, for: .normal)
        postImageArea.sd_setImage(with: viewModel.imageURL)
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
    }
    
    
    //MARK: - @objc Actions
    @objc func areaOfGoToUserProfile(){
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, wantsToShowProfileFor: viewModel.post.ownerUid)
    }
    
    
    @objc func commentsClicked(){
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, showCommentsFor: viewModel.post)
    }
    
    
    @objc func didTapLikeButton() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, didLike: viewModel.post)
    }
}


