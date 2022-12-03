//
//  UploadPostVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 2.12.2022.
//

import UIKit

final class UploadPostVC: UIViewController {
    
    
    //MARK: - UI Elements
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    
    private lazy var captionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 0.3
        textView.layer.borderColor = UIColor.lightGray.cgColor
        return textView
    }()
    
    private lazy var characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font      = UIFont.systemFont(ofSize: 14)
        label.text      = "0/100"
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUploadPostVC()
        configureUIElements()
    }
    
    
    //MARK: - Helpers
    private func configureUploadPostVC() {
        view.backgroundColor              = .white
        navigationItem.title              = "Upload Post"
        navigationItem.leftBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(shareButtonPressed))
    }
    
    
    private func configureUIElements() {
        view.addSubviewsExt(photoImageView, captionTextView, characterCountLabel)
        photoImageView.setDimensions(height: 240, width: 240)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 5)
        photoImageView.centerX(inView: view)
        captionTextView.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 12, paddingRight: 12, height: 64)
        characterCountLabel.anchor(top: captionTextView.bottomAnchor, right: captionTextView.rightAnchor, paddingTop: 5)
    }
    
    
    //MARK: - @objc Actions
    @objc private func cancelButtonPressed() {
        dismiss(animated: false)
    }
    
    @objc private func shareButtonPressed() {
        print("Share button pressed")
    }

}
