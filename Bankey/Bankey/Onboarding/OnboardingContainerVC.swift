//
//  OnboardingContainerVc.swift
//  Bankey
//
//  Created by Bryan Yong on 05/09/2022.
//


import UIKit

protocol OnboardingContainerVCDelegate : AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    let btnClose = UIButton(type: .system)
    let btnDone  = UIButton(type: .system)
    
    weak var delegateOnboarding : OnboardingContainerVCDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingVC(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s.")
        let page2 = OnboardingVC(heroImageName: "world", titleText: "Move your money around the world quicky and securely.")
        let page3 = OnboardingVC(heroImageName: "thumbs", titleText: "Learn more at www.bankey.com")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
    
    private func setup(){
        view.backgroundColor = .systemPurple
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    
    private func style(){
        btnClose.translatesAutoresizingMaskIntoConstraints = false
        btnClose.setTitle("Close", for: [])
        btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .primaryActionTriggered)
        
        btnDone.translatesAutoresizingMaskIntoConstraints = false
        btnDone.setTitle("Done", for: [])
        btnDone.addTarget(self, action: #selector(btnDoneTapped), for: .primaryActionTriggered)
    }
    
    private func layout(){
        view.addSubview(btnClose)
        view.addSubview(btnDone)
        btnDone.isHidden = true
        
        NSLayoutConstraint.activate([
            btnClose.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            btnClose.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
//            btnDone.trailingAnchor.constraint(equalToSystemSpacingAfter: pageViewController.view.trailingAnchor, multiplier: 2),
            
            pageViewController.view.trailingAnchor.constraint(equalToSystemSpacingAfter: btnDone.trailingAnchor, multiplier: 2),
            
            pageViewController.view.bottomAnchor.constraint(equalToSystemSpacingBelow: btnDone.bottomAnchor, multiplier: 8)
            
//            btnDone.bottomAnchor.constraint(equalToSystemSpacingBelow: pageViewController.view.bottomAnchor, multiplier: 2)
        ])
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        
        // last page
        if (index + 1) == pages.count - 1 {
            btnDone.isHidden = false
        }
        
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}


// MARK: - Actions
extension OnboardingContainerViewController {
    @objc func btnCloseTapped(_ sender : UIButton){
        delegateOnboarding?.didFinishOnboarding()
    }
    
    @objc func btnDoneTapped(_ sender: UIButton){
        delegateOnboarding?.didFinishOnboarding()
    }
}
