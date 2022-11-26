//
//  SearchCell.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 25.11.2022.
//

import UIKit

class SearchCell: UITableViewCell {
    
    //MARK: - Properties
    static let reuseID = "SearchCell"
    
    
    //MARK: - UI Elements
    private lazy var profileImageView: UIImageView = {
        let imageView             = UIImageView()
        imageView.contentMode     = .scaleAspectFill
        imageView.clipsToBounds   = true
        imageView.backgroundColor = .lightGray
        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label                 = UILabel()
        label.font                = UIFont.boldSystemFont(ofSize: 15)
        label.text                = "Username"
        return label
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label                 = UILabel()
        label.font                = UIFont.systemFont(ofSize: 15)
        label.text                = "Fullname"
        label.textColor           = .lightGray
        return label
    }()
    
    private lazy var namesStackView: UIStackView = {
        let stackView             = UIStackView(arrangedSubviews: [userNameLabel, fullNameLabel])
        stackView.axis            = .vertical
        stackView.spacing         = 5
        stackView.alignment       = .leading
        return stackView
    }()
    
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    private func configure() {
        addSubviewsExt(profileImageView, namesStackView)
        profileImageView.setDimensions(height: 50, width: 50)
        profileImageView.layer.cornerRadius = 25
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        namesStackView.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        

    }

}
