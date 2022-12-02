//
//  UploadPostVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 2.12.2022.
//

import UIKit

final class UploadPostVC: UIViewController {
    
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor              = .white
        navigationItem.title              = "Upload Post"
        navigationItem.leftBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(shareButtonPressed))
    }
    
    
    //MARK: - @objc Actions
    @objc private func cancelButtonPressed() {
        dismiss(animated: false)
    }
    
    @objc private func shareButtonPressed() {
        print("Share button pressed")
    }

}
