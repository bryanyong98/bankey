//
//  AppDelegate.swift
//  Bankey
//
//  Created by Bryan Yong on 04/09/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    
    let loginViewController      = LoginViewController()
    let onboardingViewController = OnboardingContainerViewController()
    let dummyViewController      = DummyViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
//        window?.rootViewController = LoginViewController()
        loginViewController.delegate = self
        onboardingViewController.delegateOnboarding = self
        dummyViewController.delegateLogout = self
        window?.rootViewController = loginViewController

        return true
    }
}

extension AppDelegate : LoginViewControllerDelegate {
    func didLogin() {
        print("Did login")

        if LocalState.hasOnboarded {
            setRootViewController(dummyViewController)
        } else {
            setRootViewController(onboardingViewController)
        }
        
    }
}

extension AppDelegate : OnboardingContainerVCDelegate {
    func didFinishOnboarding() {
        print("Finish onboarding.")
        LocalState.hasOnboarded = true
        setRootViewController(dummyViewController)
    }
}

extension AppDelegate : LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true){
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

