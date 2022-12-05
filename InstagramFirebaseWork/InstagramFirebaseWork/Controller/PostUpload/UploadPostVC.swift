//
//  UploadPostVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 2.12.2022.
//

import UIKit

protocol UploadPostVCDelegateProtocol: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostVC)
}

final class UploadPostVC: UIViewController {
    
    //MARK: - Properties
    var selectedImage: UIImage? {
        didSet { photoImageView.image = selectedImage }
    }
    weak var delegate: UploadPostVCDelegateProtocol?
    
    //MARK: - UI Elements
    private lazy var photoImageView: UIImageView = {
        let imageView                     = UIImageView()
        imageView.contentMode             = .scaleAspectFill
        imageView.clipsToBounds           = true
        imageView.layer.cornerRadius      = 10
        return imageView
    }()
    
    private lazy var captionTextView: InputTextView = {
        let textView = InputTextView()
        textView.placeHolderText          = "Enter Caption"
        textView.font                     = UIFont.systemFont(ofSize: 20)
        textView.layer.cornerRadius       = 10
        textView.layer.borderWidth        = 0.3
        textView.layer.borderColor        = UIColor.lightGray.cgColor
        textView.delegate = self
        return textView
    }()
    
    private lazy var characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor                   = .lightGray
        label.font                        = UIFont.systemFont(ofSize: 20)
        label.text                        = "0/100"
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
        captionTextView.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 12, paddingRight: 12, height: 90)
        characterCountLabel.anchor(top: captionTextView.bottomAnchor, right: captionTextView.rightAnchor, paddingTop: 5)
    }
    
    
    private func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
    
    
    //MARK: - @objc Actions
    @objc private func cancelButtonPressed() {
        dismiss(animated: false)
    }
    
    
    @objc private func shareButtonPressed() {
        guard let image = selectedImage, let caption = captionTextView.text else { return }
        showLoader(true)
        PostService.uploadPost(caption: caption, image: image) { error in
            if let error = error {
                print("DEBUG ERROR. FAILED TO UPLOAD POST WITH ERROR: \(error.localizedDescription)")
                return
            }
            //self.dismiss(animated: true)
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
        showLoader(false)
    }
}


//MARK: UITextViewDelegate
extension UploadPostVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}
