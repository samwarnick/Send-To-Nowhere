//
//  STNAboutPageViewController.swift
//  Nowhere
//
//  Created by Sam Warnick on 4/7/17.
//  Copyright © 2017 Sam Warnick. All rights reserved.
//

import UIKit

class STNAboutPageViewController: UIPageViewController {
    
    // MARK: - Properties
    
    private let aboutViewController = STNAboutViewController()
    private let creditsViewController = STNCreditsViewController()
    private var orderedViewControllers: [UIViewController] = []
    private var theme = AppState.sharedInstance.currentTheme
    private let doneButton = UIButton(type: .system)
    
    var pageControl = UIPageControl()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        orderedViewControllers = [aboutViewController, creditsViewController]
        setViewControllers([orderedViewControllers.first!], direction: .forward, animated: true, completion: nil)
        
        configureViews()
    }

    func configureViews() {
        
        theme = AppState.sharedInstance.currentTheme
        
        doneButton.setImage(UIImage(named: "exit"), for: .normal)
        doneButton.tintColor = theme.secondary
        doneButton.addTarget(self, action: #selector(STNAboutPageViewController.didPressDoneButton), for: .touchUpInside)

        view.addSubview(doneButton)

        doneButton.snp.makeConstraints{ (make) -> Void in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            } else {
                make.top.equalTo(view).offset(30)
            }
            make.right.equalTo(view).offset(-20)
        }
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.stnColumbiaBlue
        pageControl.currentPageIndicatorTintColor = theme.secondary
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints{ (make) -> Void in
            if #available(iOS 11, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            }
            make.centerX.equalTo(view)
        }
        
        view.fadeTransition(duration: 0.25)
        view.backgroundColor = theme.primary
    }
    
    func refreshViews() {
        configureViews()
        aboutViewController.configureViews()
        creditsViewController.configureViews()
        if let parentController = presentingViewController as? STNMainViewController {
            parentController.configureViews()
        }
    }
    
    // MARK: - Actions
    
    @objc func didPressDoneButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource

extension STNAboutPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        pageControl.currentPage = viewControllerIndex
        
        let previousIndex = viewControllerIndex - 1
        
        if previousIndex < 0 {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        pageControl.currentPage = viewControllerIndex
        
        let nextIndex = viewControllerIndex + 1

        if nextIndex > orderedViewControllers.count - 1 {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
