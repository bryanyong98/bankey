//
//  LoginView.swift
//  Bankey
//
//  Created by Bryan Yong on 04/09/2022.
//

import Foundation
import UIKit

class LoginView : UIView {
    
    let stackView   = UIStackView()
    let tfUsername  = UITextField()
    let tfPassword  = UITextField()
    let dividerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented.")
    }
    
}

extension LoginView {
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        
        layer.cornerRadius = 10
        clipsToBounds = true  // clip it around the corner
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        tfUsername.translatesAutoresizingMaskIntoConstraints = false
        tfUsername.placeholder = "Username"
        tfUsername.delegate = self
        
        tfPassword.translatesAutoresizingMaskIntoConstraints = false
        tfPassword.placeholder = "Password"
        tfPassword.isSecureTextEntry = true  // make words masked
        tfPassword.delegate = self
        tfPassword.enablePasswordToggle()
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
    }
    
    func layout(){
        
        stackView.addArrangedSubview(tfUsername)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(tfPassword)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
        
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

// MARK: - UITextFieldDelegate
extension LoginView : UITextFieldDelegate {
    // end the text field editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfUsername.endEditing(true)
        tfPassword.endEditing(true)
        return true
    }
    
    // a callback to check some conditions
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true 
    }
    
    // textFieldDidEndEditing
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
