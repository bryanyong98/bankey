//
//  DummyViewController.swift
//  Bankey
//
//  Created by Bryan Yong on 09/09/2022.
//

import UIKit

class DummyViewController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let btnLogout = UIButton(type: .system)
    
    weak var delegateLogout : LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension DummyViewController {
    
    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        btnLogout.translatesAutoresizingMaskIntoConstraints = false
        btnLogout.setTitle("Logout", for: [])
        btnLogout.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout(){
        stackView.addArrangedSubview(label)  // for stackview purposes
        stackView.addArrangedSubview(btnLogout)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func logoutButtonTapped(sender: UIButton){
        delegateLogout?.didLogout()
    }
}




