//
//  InputTextView.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 3.12.2022.
//

import UIKit

class InputTextView: UITextView {
    
    //MARK: - Properties
    var placeHolderText: String? { didSet { placeHolderLabel.text = placeHolderText } }

    
    //MARK: - UIElements
    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureTextView()
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Configure
    private func configureTextView() {
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 8)
    }
    
    
    //MARK: - @objc Actions
    @objc private func handleTextChange() {
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
