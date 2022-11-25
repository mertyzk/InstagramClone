//
//  ProfileHeader.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 22.11.2022.
//

import Foundation
import UIKit
import SDWebImage

class ProfileHeader: UICollectionReusableView {
    
    //MARK: - Properties
    static let reuseID = "profileHeader"
    
    var viewModel: ProfileHeaderViewModel? {
        didSet { setData() }
    }
    
    
    //MARK: - UIElements
    private lazy var profileImageView: UIImageView = {
        let imageArea                       = UIImageView()
        imageArea.clipsToBounds             = true
        imageArea.contentMode               = .scaleAspectFill
        imageArea.backgroundColor           = .lightGray
        return imageArea
    }()
    
    private lazy var nameLabel: UILabel     = {
        let label                           = UILabel()
        label.font                          = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var postsLabel: UILabel    = {
        let label                           = UILabel()
        label.numberOfLines                 = 0
        label.textAlignment                 = .center
        label.attributedText                = attributedTextForLabel(value: 9, label: "posts")
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label                           = UILabel()
        label.numberOfLines                 = 0
        label.textAlignment                 = .center
        label.attributedText                = attributedTextForLabel(value: 123, label: "followers")
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label                           = UILabel()
        label.numberOfLines                 = 0
        label.textAlignment                 = .center
        label.attributedText                = attributedTextForLabel(value: 256, label: "following")
        return label
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius           = 4
        button.layer.borderWidth            = 1
        button.layer.borderColor            = UIColor.systemGray4.cgColor
        button.titleLabel?.font             = UIFont.systemFont(ofSize: 14)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(editProfileButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView                       = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        stackView.axis                      = .horizontal
        stackView.distribution              = .fillEqually
        return stackView
    }()
    
    private lazy var gridButton: UIButton   = {
        let button                          = UIButton(type: .system)
        button.tintColor                    = .black
        button.setImage(ProfileHeaderImages.gridImage, for: .normal)
        return button
    }()
    
    private lazy var listButton: UIButton   = {
        let button                          = UIButton(type: .system)
        button.tintColor                    = .black
        button.setImage(ProfileHeaderImages.listImage, for: .normal)
        return button
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button                          = UIButton(type: .system)
        button.tintColor                    = .black
        button.setImage(ProfileHeaderImages.bookmarkImage, for: .normal)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView                       = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis                      = .horizontal
        stackView.distribution              = .fillEqually
        return stackView
    }()
    
    lazy var topDivider: UIView = {
        let myView                          = UIView()
        myView.backgroundColor              = .lightGray
        return myView
    }()
    
    lazy var bottomDivider: UIView = {
        let myView                          = UIView()
        myView.backgroundColor              = .lightGray
        return myView
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
        backgroundColor = .white
        addSubviewsExt(profileImageView, nameLabel, editProfileButton, headerStackView, buttonStackView, topDivider, bottomDivider)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 20)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 40
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: profileImageView.leftAnchor, paddingTop: 10, paddingLeft: 0)
        editProfileButton.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20)
        headerStackView.centerY(inView: profileImageView)
        headerStackView.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 20, height: 50)
        buttonStackView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        topDivider.anchor(top: buttonStackView.topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        bottomDivider.anchor(top: buttonStackView.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    
    
    private func attributedTextForLabel(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font : UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
    
    
    private func setData() {
        guard let viewModel                 = viewModel else { return }
        nameLabel.text                      = viewModel.fullname
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
    }
    
    
    //MARK: - addTarget @objc Functions
    @objc func editProfileButtonClicked(){
        print("Clicked at username button")
    }
}
