//
//  LoginVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 17.11.2022.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - Variables
    private var viewModel = LoginViewModel()
    
    
    //MARK: - UI Elements
    private lazy var instaLogoImage: UIImageView = {
        let logoImage                   = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        logoImage.contentMode           = .scaleAspectFill
        return logoImage
    }()
    
    private lazy var emailTextField: UITextField = {
        let textfield                   = CustomTextField(placeHolder: LoginRegisterStrings.emailAdress, isSecureTextEntry: false)
        textfield.keyboardType          = .emailAddress
        return textfield
    }()
    
    private lazy var passwordTextField = CustomTextField(placeHolder: LoginRegisterStrings.enterPassword, isSecureTextEntry: true)
    
    private lazy var loginButton: UIButton = {
        let button                       = UIButton(type: .system)
        button.setHeight(50)
        button.setTitle(LoginRegisterStrings.login, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor          = #colorLiteral(red: 0.3591802418, green: 0.3747666478, blue: 0.5265965462, alpha: 1)
        button.layer.cornerRadius       = 15
        button.titleLabel?.font         = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled                = false
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
        button.attributedTitle(firstPart: LoginRegisterStrings.dontHaveAccount, secondPart: LoginRegisterStrings.signUp)
        button.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: LoginRegisterStrings.forgotPassword, secondPart: LoginRegisterStrings.getHelp)
        return button
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setNotificationObservers()
    }
    
    
    //MARK: - Helpers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
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
    
    
    func setNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textHasChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textHasChanged), for: .editingChanged)
    }
    
    
    //MARK: - @objc Action Helpers
    @objc func signUpClicked() {
        let registerVC = RegisterVC()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    @objc func textHasChanged(sender: UITextField) {
        switch sender {
        case emailTextField:
            viewModel.email = sender.text
        case passwordTextField:
            viewModel.password = sender.text
        default:
            break
        }
        updateForm()
    }
}


//MARK: - Extension FormViewModel
extension LoginVC: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBGColor
        loginButton.isEnabled       = viewModel.formIsValid
    }
}
