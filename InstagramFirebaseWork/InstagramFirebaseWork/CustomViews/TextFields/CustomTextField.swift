//
//  CustomTextField.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 18.11.2022.
//

import UIKit

class CustomTextField: UITextField {
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(placeHolder: String, isSecureTextEntry: Bool) {
        self.init(frame: .zero)
        set(placeHolder: placeHolder, isSecureTextEntry: isSecureTextEntry)
    }
    
    
    //MARK: - Returns the drawing rectangle for the text field’s text.
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }
    
    
    //MARK: - Helper Functions
    private func configure() {
        setHeight(50)
        borderStyle           = .none
        textColor             = .white
        keyboardAppearance    = .dark
        returnKeyType         = .done
        backgroundColor       = UIColor(white: 1, alpha: 0.1)
        layer.cornerRadius    = 15
    }
    
    private func set(placeHolder: String, isSecureTextEntry: Bool) {
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        self.isSecureTextEntry     = isSecureTextEntry
    }
}
