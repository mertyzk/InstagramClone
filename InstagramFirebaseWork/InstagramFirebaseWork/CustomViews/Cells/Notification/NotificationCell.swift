//
//  NotificationCell.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 17.12.2022.
//

import UIKit

protocol NotificationCellDelegateProtocol: AnyObject {
    func cell(_ cell: NotificationCell, wantsToFollow uid: String)
    func cell(_ cell: NotificationCell, wantsToUnfollow uid: String)
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String)
}

class NotificationCell: UITableViewCell {
    
    //MARK: - Properties
    static let reuseID = "NotificationCell"
    weak var delegate: NotificationCellDelegateProtocol?
    var viewModel: NotificationViewModel? {
        didSet {
            configureData()
        }
    }
    
    
    //MARK: - UI Elements
    private lazy var profileImageView: UIImageView = {
        let imageArea                       = UIImageView()
        imageArea.clipsToBounds             = true
        imageArea.contentMode               = .scaleAspectFill
        imageArea.backgroundColor           = .lightGray
        imageArea.isUserInteractionEnabled  = true
        let gestureRecognizer               = UITapGestureRecognizer(target: self, action: #selector(profileImageClicked))
        imageArea.addGestureRecognizer(gestureRecognizer)
        return imageArea
    }()
    
    private lazy var infoLabel: UILabel     = {
        let label                           = UILabel()
        label.numberOfLines                 = 0
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageArea                       = UIImageView()
        imageArea.contentMode               = .scaleAspectFill
        imageArea.clipsToBounds             = true
        imageArea.backgroundColor           = .systemGray5
        imageArea.isUserInteractionEnabled  = true
        let gestureRecognizer               = UITapGestureRecognizer(target: self, action: #selector(postImageClicked))
        imageArea.addGestureRecognizer(gestureRecognizer)
        return imageArea
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius           = 4
        button.layer.borderWidth            = 1
        button.layer.borderColor            = UIColor.systemGray4.cgColor
        button.titleLabel?.font             = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(followButtonClicked), for: .touchUpInside)
        return button
    }()

    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    private func configureUI(){
        backgroundColor = .white
        selectionStyle  = .none
        addSubviewsExt(profileImageView, infoLabel, followButton, postImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 20)
        profileImageView.setDimensions(height: 50, width: 50)
        profileImageView.layer.cornerRadius = 25
        followButton.centerY(inView: self)
        followButton.anchor(right: rightAnchor, paddingRight: 12, width: 88, height: 32)
        postImageView.centerY(inView: self)
        postImageView.anchor(right: rightAnchor, paddingRight: 12, width: 40, height: 40)
        infoLabel.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        infoLabel.anchor(right: followButton.leftAnchor, paddingRight: 4)
        followButton.isHidden = true
    }
    
    
    private func configureData() {
        guard let viewModel          = viewModel else { return }
        infoLabel.attributedText     = viewModel.notificationMessage
        followButton.isHidden        = viewModel.shouldHideFollowButton
        postImageView.isHidden       = viewModel.shouldHidePostImage
        followButton.backgroundColor = viewModel.followButtonBGColor
        followButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        followButton.setTitle(viewModel.followButtonText, for: .normal)
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        postImageView.sd_setImage(with: viewModel.postImageURL)
    }
    
    
    //MARK: - @objc Actions
    @objc private func followButtonClicked() {
        guard let viewModel      = viewModel else { return }
        delegate?.cell(self, wantsToFollow: viewModel.uid)
    }
    
    
    @objc private func postImageClicked() {
        guard let viewModel      = viewModel else { return }
        delegate?.cell(self, wantsToFollow: viewModel.postId!)
    }
    
    
    @objc private func profileImageClicked() {
        print("profile image tapped")
    }
    
}
