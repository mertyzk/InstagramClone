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
    var viewModel: CommentViewModel? {
        didSet {
            configure()
        }
    }
    
    //MARK: - UI Elements
    private lazy var profileImageView: UIImageView = {
        let imageView                = UIImageView()
        imageView.contentMode        = .scaleAspectFill
        imageView.clipsToBounds      = true
        imageView.backgroundColor    = .lightGray
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private lazy var commentLabel = UILabel()
    
    
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
        commentLabel.numberOfLines = 0
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        commentLabel.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
        commentLabel.anchor(right: rightAnchor, paddingRight: 12)
    }
    
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        commentLabel.attributedText = viewModel.commentLabelText()
    }
}
