//
//  ResetPasswordVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 23.12.2022.
//

import UIKit

class ResetPasswordVC: UIViewController {

    //MARK: - UI Elements
    private lazy var emailTextField = CustomTextField(placeHolder: LoginRegisterStrings.emailAdress, isSecureTextEntry: false)
    private lazy var iconImage      = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
    private lazy var resetPasswordButton: UIButton = {
        let button                  = UIButton(type: .system)
        button.setHeight(50)
        button.setTitle(LoginRegisterStrings.resetPassword, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor      = #colorLiteral(red: 0.3591802418, green: 0.3747666478, blue: 0.5265965462, alpha: 1)
        button.layer.cornerRadius   = 15
        button.titleLabel?.font     = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled            = false
        button.addTarget(self, action: #selector(resetPasswordClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button                  = UIButton(type: .system)
        button.tintColor            = .white
        button.setImage(SYSImages.chevron, for: .normal)
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetStackView: UIStackView = {
        let stackView                   = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
        stackView.axis                  = .vertical
        stackView.spacing               = 22
        return stackView
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: - Helpers
    private func configureUI() {
        setGradient()
        view.addSubviewsExt(backButton, iconImage, resetStackView)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 15, paddingLeft: 15)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 180)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 44)
        resetStackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 35, paddingLeft: 35, paddingRight: 35)
    }
    
    
    //MARK: - @objc Actions
    @objc private func resetPasswordClicked() {
        print("---->>> DEBUG:")
    }
    
    
    @objc private func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

}
