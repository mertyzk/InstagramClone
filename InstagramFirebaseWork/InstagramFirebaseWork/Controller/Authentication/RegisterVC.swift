//
//  RegisterVC.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 17.11.2022.
//

import UIKit

final class RegisterVC: UIViewController {
    
    //MARK: - Variables
    private var viewModel                     = RegisterViewModel()
    private var profileImage: UIImage?
    weak var delegate: AuthenticationProtocol?
    
    //MARK: - UI Elements
    private lazy var selectPhotoButton: UIButton = {
        let button                            = UIButton(type: .system)
        button.tintColor                      = .white
        button.setImage(RegisterImages.selectPhoto, for: .normal)
        button.addTarget(self, action: #selector(selectProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailTextField: UITextField = {
        let textfield                         = CustomTextField(placeHolder: LoginRegisterStrings.emailAdress, isSecureTextEntry: false)
        textfield.keyboardType                = .emailAddress
        return textfield
    }()
    
    private lazy var passwordTextField        = CustomTextField(placeHolder: LoginRegisterStrings.enterPassword, isSecureTextEntry: true)
    private lazy var fullNameTextField        = CustomTextField(placeHolder: LoginRegisterStrings.fullName, isSecureTextEntry: false)
    private lazy var usernameTextField        = CustomTextField(placeHolder: LoginRegisterStrings.userName, isSecureTextEntry: false)
    
    private lazy var signUpButton: UIButton   = {
        let button                            = UIButton(type: .system)
        button.setHeight(50)
        button.setTitle(LoginRegisterStrings.signUp, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor                = #colorLiteral(red: 0.3591802418, green: 0.3747666478, blue: 0.5265965462, alpha: 1)
        button.layer.cornerRadius             = 15
        button.titleLabel?.font               = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled                      = false
        button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerStackView: UIStackView = {
        let stackView                         = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, usernameTextField, signUpButton])
        stackView.axis                        = .vertical
        stackView.spacing                     = 15
        return stackView
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: LoginRegisterStrings.alreadyHaveAccount, secondPart: LoginRegisterStrings.login)
        button.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setNotificationObservers()
    }
    
    
    //MARK: - Helpers
    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        setGradient()
        view.addSubviewsExt(selectPhotoButton, registerStackView, alreadyHaveAccountButton)
        selectPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)
        selectPhotoButton.setDimensions(height: 140, width: 140)
        selectPhotoButton.centerX(inView: view)
        registerStackView.anchor(top: selectPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20)
        alreadyHaveAccountButton.centerX(inView: view)
    }
    
    
    private func setNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textHasChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textHasChanged), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textHasChanged), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textHasChanged), for: .editingChanged)
        
    }
    
    //MARK: - @objc Actions
    @objc private func loginClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func selectProfilePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    @objc private func textHasChanged(sender: UITextField) {
        switch sender {
        case emailTextField:
            viewModel.email                   = sender.text
        case passwordTextField:
            viewModel.password                = sender.text
        case fullNameTextField:
            viewModel.fullname                = sender.text
        case usernameTextField:
            viewModel.username                = sender.text?.lowercased()
        default:
            break
        }
        updateForm()
    }
    
    
    @objc private func signUpButtonClicked() {
        guard let email                       = emailTextField.text else { return }
        guard let password                    = passwordTextField.text else { return }
        guard let fullname                    = fullNameTextField.text else { return }
        guard let username                    = usernameTextField.text?.lowercased() else { return }
        guard let profileImage = self.profileImage else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        
        AuthService.registerUser(withCredential: credentials) { error in
            if error != nil {
                print("Register error: \(error?.localizedDescription)")
                return
            }
            self.delegate?.authenticationComplete()
        }
    }
}


//MARK: - Protocol FormViewModel
extension RegisterVC: FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor          = viewModel.buttonBGColor
        signUpButton.isEnabled                = viewModel.formIsValid
    }
}


//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage               = info[.editedImage] as? UIImage else { return }
        profileImage                          = selectedImage
        selectPhotoButton.layer.cornerRadius  = selectPhotoButton.frame.width / 2
        selectPhotoButton.layer.masksToBounds = true
        selectPhotoButton.layer.borderColor   = UIColor.white.cgColor
        selectPhotoButton.layer.borderWidth   = 1.5
        selectPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true)
    }
}
