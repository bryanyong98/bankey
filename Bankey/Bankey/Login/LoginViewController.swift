//
//  ViewController.swift
//  Bankey
//
//  Created by Bryan Yong on 04/09/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let btnSignIn = UIButton(type: .system)
    let labelErrorMessage = UILabel()
    let labelTitle = UILabel()
    let labelSubtitle = UILabel()
    
    var username : String? {
        return loginView.tfUsername.text
    }
    
    var password : String? {
        return loginView.tfPassword.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }
}

extension LoginViewController {
    private func style(){
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        btnSignIn.translatesAutoresizingMaskIntoConstraints = false
        btnSignIn.setTitle("Sign In", for: [])
        btnSignIn.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        btnSignIn.backgroundColor = .systemBlue
        btnSignIn.setTitleColor(.white, for: .normal)
        btnSignIn.layer.cornerRadius = 5
        
        labelErrorMessage.translatesAutoresizingMaskIntoConstraints = false
        labelErrorMessage.text = "Username / password cannot be blank"
        labelErrorMessage.textAlignment = .center
        labelErrorMessage.textColor = .systemRed
        labelErrorMessage.numberOfLines = 0
        labelErrorMessage.isHidden = true
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        labelTitle.adjustsFontForContentSizeCategory = true
        labelTitle.text = "Bankey"
        
        labelSubtitle.translatesAutoresizingMaskIntoConstraints = false
        labelSubtitle.textAlignment = .center
        labelSubtitle.font = UIFont.preferredFont(forTextStyle: .title3)
        labelSubtitle.adjustsFontForContentSizeCategory = true
        labelSubtitle.numberOfLines = 2
        labelSubtitle.text = "Your premium source for all things banking!"
    }
    
    private func layout(){
        view.addSubview(loginView)
        view.addSubview(btnSignIn)
        view.addSubview(labelErrorMessage)
        view.addSubview(labelTitle)
        view.addSubview(labelSubtitle)
        
        // LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1), 
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
    
        // Button Sign In
        NSLayoutConstraint.activate([
            btnSignIn.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            btnSignIn.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            btnSignIn.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        btnSignIn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Label Error Message
        NSLayoutConstraint.activate([
            labelErrorMessage.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            labelErrorMessage.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            labelErrorMessage.topAnchor.constraint(equalToSystemSpacingBelow: btnSignIn.bottomAnchor, multiplier: 2)
        ])
        
        // Label Title
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor), 
            labelSubtitle.topAnchor.constraint(equalToSystemSpacingBelow: labelTitle.bottomAnchor, multiplier: 3)
        ])
        
        // Label Subtitle
        NSLayoutConstraint.activate([
            labelSubtitle.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: labelSubtitle.trailingAnchor, multiplier: 3),
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: labelSubtitle.bottomAnchor, multiplier: 3)
        ])
    }
}

// MARK: - Actions
extension LoginViewController {
    @objc func signInTapped(sender: UIButton){
        labelErrorMessage.isHidden = true
        login()
        
    }
    
    private func login(){
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "Bryan" && password == "bryan123" {
        } else {
            configureView(withMessage: "Incorrect username / password ")
        }
        
    }
    
    private func configureView(withMessage message : String){
        labelErrorMessage.isHidden = false
        labelErrorMessage.text = message
    }
}

