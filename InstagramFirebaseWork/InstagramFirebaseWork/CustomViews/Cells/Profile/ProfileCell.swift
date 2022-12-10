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
    var viewModel: PostViewModel? {
        didSet {
            configure()
        }
    }
    
    //MARK: - UIElements
    private lazy var postImageView: UIImageView = {
        let imageArea                       = UIImageView()
        imageArea.clipsToBounds             = true
        imageArea.contentMode               = .scaleAspectFill
        return imageArea
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
        backgroundColor = .lightGray
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        postImageView.sd_setImage(with: viewModel.imageURL)
    }
}
