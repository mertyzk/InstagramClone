//
//  CommentInputAccesoryView.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 10.12.2022.
//

import UIKit

class CommentInputAccesoryView: UIView {
    
    //MARK: - Properties
    
    
    //MARK: - UI Elements
    private lazy var commentTextView: InputTextView = {
        let textView                     = InputTextView()
        textView.placeHolderText         = "Enter comment..."
        textView.font                    = UIFont.systemFont(ofSize: 15)
        textView.isScrollEnabled         = false
        textView.placeholderShouldCenter = true
        return textView
    }()
    
    private lazy var postButton: UIButton = {
        let button                       = UIButton(type: .system)
        button.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Post", for: .normal)
        button.addTarget(self, action: #selector(postButtonClicked), for: .touchUpInside)
        return button
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
    private func configureUIElements() {
        autoresizingMask = .flexibleHeight
        
        let padding: CGFloat = 8
        addSubviewsExt(postButton, commentTextView)
        postButton.anchor(top: topAnchor, right: rightAnchor, paddingRight: padding)
        postButton.setDimensions(height: 50, width: 50)
        commentTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: postButton.leftAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    

    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    
    
    //MARK: - @objc Actions
    @objc private func postButtonClicked() {
        
    }
}
