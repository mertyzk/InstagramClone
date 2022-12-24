//
//  LoginVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 17.11.2022.
//

import UIKit

protocol AuthenticationProtocol: AnyObject {
    func authenticationComplete()
}

final class LoginVC: UIViewController {
    
    //MARK: - Properties
    private var viewModel = LoginViewModel()
    weak var delegate: AuthenticationProtocol?
    
    
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
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(forgotPasswordClicked), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTargets()
    }
    
    
    //MARK: - Helpers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    private func configureUI() {
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
    
    
    private func configureTargets() {
        emailTextField.addTarget(self, action: #selector(textHasChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textHasChanged), for: .editingChanged)
    }
    
    
    //MARK: - @objc Actions
    @objc private func signUpClicked() {
        let registerVC = RegisterVC()
        registerVC.delegate = delegate
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    @objc private func textHasChanged(sender: UITextField) {
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
    
    
    @objc private func loginButtonPressed() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        AuthService.login(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.delegate?.authenticationComplete()
        }
    }
    
    
    @objc private func forgotPasswordClicked() {
        let resetPassVC      = ResetPasswordVC(email: emailTextField.text)
        resetPassVC.delegate = self
        navigationController?.pushViewController(resetPassVC, animated: true)
    }
}


//MARK: - Extension FormViewModel
extension LoginVC: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBGColor
        loginButton.isEnabled       = viewModel.formIsValid
    }
}


//MARK: - Extension ResetPassword
extension LoginVC: ResetPasswordControllerDelegateProtocol {
    func controllerDidSendResetPasswordLink(_ controller: ResetPasswordVC) {
        navigationController?.popViewController(animated: true)
        showMessage(withTitle: LoginRegisterStrings.resetSuccessTitle, message: LoginRegisterStrings.resetSuccessString)
    } 
}
