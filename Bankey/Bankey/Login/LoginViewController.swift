//
//  ViewController.swift
//  Bankey
//
//  Created by Bryan Yong on 04/09/2022.
//

import UIKit

protocol LogoutDelegate : AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate : AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let btnSignIn = UIButton(type: .system)
    let labelErrorMessage = UILabel()
    let labelTitle = UILabel()
    let labelSubtitle = UILabel()
    
    weak var delegate : LoginViewControllerDelegate?
    
    var username : String? {
        return loginView.tfUsername.text
    }
    
    var password : String? {
        return loginView.tfPassword.text
    }
    
    // animation
    var leadingEdgeOnScreen : CGFloat = 16
    var leadingEdgeOffScreen : CGFloat = -1000
    
    var titleLeadingAnchor : NSLayoutConstraint?
    var subTitleLeadingAnchor : NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
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
        labelTitle.alpha = 0
        labelTitle.text = "Bankey"
        
        labelSubtitle.translatesAutoresizingMaskIntoConstraints = false
        labelSubtitle.textAlignment = .center
        labelSubtitle.font = UIFont.preferredFont(forTextStyle: .title3)
        labelSubtitle.adjustsFontForContentSizeCategory = true
        labelSubtitle.numberOfLines = 2
        labelSubtitle.alpha = 0
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
            labelTitle.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            labelSubtitle.topAnchor.constraint(equalToSystemSpacingBelow: labelTitle.bottomAnchor, multiplier: 3)
        ])
        
        titleLeadingAnchor = labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
        // Label Subtitle
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: labelSubtitle.trailingAnchor, multiplier: 3),
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: labelSubtitle.bottomAnchor, multiplier: 3)
        ])
        
        subTitleLeadingAnchor = labelSubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        subTitleLeadingAnchor?.isActive = true
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
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password ")
        }
        
    }
    
    private func configureView(withMessage message : String){
        labelErrorMessage.isHidden = false
        labelErrorMessage.text = message
        shakeButton()
    }
    
    private func shakeButton(){
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        btnSignIn.layer.add(animation, forKey: "shake")
    }
}

// MARK: - Animations
extension LoginViewController {
    private func animate(){
        
        let duration = 2.0
        
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut){
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()  // tell auto layout engine we need to update the constraints immediately because we changed the value
        }
        
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut){
            self.subTitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        let animator3 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut){
            self.labelTitle.alpha = 1
            self.labelSubtitle.alpha = 1 
            self.view.layoutIfNeeded()
        }
        
        animator1.startAnimation()
        animator2.startAnimation(afterDelay: 1)
        animator3.startAnimation(afterDelay: 1)
    }
}
