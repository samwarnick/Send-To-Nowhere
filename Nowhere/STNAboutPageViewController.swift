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
    
    let orderedViewControllers: [UIViewController] = {
        return [STNAboutViewController(), STNCreditsViewController()]
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        setViewControllers([orderedViewControllers.first!], direction: .forward, animated: true, completion: nil)
        
        configureViews()
    }

    func configureViews() {
        let doneButton = UIButton(type: .system)
        doneButton.setImage(UIImage(named: "exit"), for: .normal)
        doneButton.tintColor = UIColor.stnRichElectricBlue
        doneButton.addTarget(self, action: #selector(STNAboutPageViewController.didPressDoneButton), for: .touchUpInside)

        view.addSubview(doneButton)

        doneButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-15)
        }
        
        let pageControlAppearance = UIPageControl.appearance(whenContainedInInstancesOf: [STNAboutPageViewController.self])
        pageControlAppearance.currentPageIndicatorTintColor = UIColor.stnRichElectricBlue
        pageControlAppearance.pageIndicatorTintColor = UIColor.stnColumbiaBlue
        
        view.backgroundColor = UIColor.white
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
        
        let nextIndex = viewControllerIndex + 1

        if nextIndex > orderedViewControllers.count - 1 {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
