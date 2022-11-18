//
//  LoginVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 17.11.2022.
//

import UIKit

class LoginVC: UIViewController {

    //MARK: - Properties
    private lazy var instaLogoImage: UIImageView = {
        let logoImage                   = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        logoImage.contentMode           = .scaleAspectFill
        return logoImage
    }()
    
    private lazy var emailTextField: UITextField = {
        let textfield                   = CustomTextField(placeHolder: "E-mail address", isSecureTextEntry: false)
        textfield.keyboardType          = .emailAddress
        return textfield
    }()
    
    private lazy var passwordTextField = CustomTextField(placeHolder: "Enter password", isSecureTextEntry: true)
    
    private lazy var loginButton: UIButton = {
        let button                       = UIButton(type: .system)
        button.setHeight(50)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor          = .systemPurple
        button.layer.cornerRadius       = 15
        button.titleLabel?.font         = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView                   = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis                  = .vertical
        stackView.spacing               = 22
        return stackView
    }()
    
    private lazy var dontHaveAnAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account? ", secondPart: "Sign Up")
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password? ", secondPart: "Get Help")
        return button
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: - Helpers
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        setGradient()
        view.addSubviewsExt(instaLogoImage, loginStackView, dontHaveAnAccountButton, forgotPasswordButton)
        instaLogoImage.centerX(inView: view)
        instaLogoImage.setDimensions(height: 80, width: 180)
        instaLogoImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 44)
        loginStackView.anchor(top: instaLogoImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30)
        dontHaveAnAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10)
        dontHaveAnAccountButton.centerX(inView: view)
        forgotPasswordButton.anchor(top: loginStackView.bottomAnchor, paddingTop: 10)
        forgotPasswordButton.centerX(inView: view)
    }
    
    
    func setGradient(){
        let gradient                                = CAGradientLayer()
        gradient.colors                             = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations                          = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame                              = view.frame
    }

}
