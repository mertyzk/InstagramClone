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
        let textfield                   = UITextField()
        textfield.setHeight(50)
        textfield.borderStyle           = .none
        textfield.textColor             = .white
        textfield.keyboardAppearance    = .dark
        textfield.keyboardType          = .emailAddress
        textfield.backgroundColor       = UIColor(white: 1, alpha: 0.1)
        textfield.layer.cornerRadius    = 5
        textfield.attributedPlaceholder = NSAttributedString(string: "E-mail address", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        return textfield
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textfield                   = UITextField()
        textfield.setHeight(50)
        textfield.borderStyle           = .none
        textfield.textColor             = .white
        textfield.keyboardAppearance    = .dark
        textfield.keyboardType          = .emailAddress
        textfield.backgroundColor       = UIColor(white: 1, alpha: 0.1)
        textfield.isSecureTextEntry     = true
        textfield.layer.cornerRadius    = 5
        textfield.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        return textfield
    }()
    
    private lazy var loginButton: UIButton = {
        let button                       = UIButton(type: .system)
        button.setHeight(50)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor          = .systemPurple
        button.layer.cornerRadius       = 5
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
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.8), .font: UIFont.systemFont(ofSize: 16)]
        let attTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: atts)
        let boldAtts : [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.9), .font: UIFont.boldSystemFont(ofSize: 16)]
        attTitle.append(NSAttributedString(string: "Sign Up", attributes: boldAtts))
        button.setAttributedTitle(attTitle, for: .normal)
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.8), .font: UIFont.systemFont(ofSize: 16)]
        let attTitle = NSMutableAttributedString(string: "Forgot your password? ", attributes: atts)
        let boldAtts : [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.9), .font: UIFont.boldSystemFont(ofSize: 16)]
        attTitle.append(NSAttributedString(string: "Get Help", attributes: boldAtts))
        button.setAttributedTitle(attTitle, for: .normal)
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
        gradient.locations                          = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame                              = view.frame
    }

}
