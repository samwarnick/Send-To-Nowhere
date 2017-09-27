//
//  STNAboutViewController.swift
//  Nowhere
//
//  Created by Sam Warnick on 4/8/17.
//  Copyright © 2017 Sam Warnick. All rights reserved.
//

import UIKit

class STNAboutViewController: UIViewController {
    
    // MARK: - Properties
    
    private let firstStepLabel = UILabel()
    private let secondStepLabel = UILabel()
    private let thirdStepLabel = UILabel()
    private let aboutLabel = UILabel()
    private let alternateThemeToggle = UISwitch()
    private let aleternateThemeLabel = UILabel()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    func configureViews() {
        
        let theme = AppState.sharedInstance.currentTheme
        
        firstStepLabel.defaultStlye(color: theme.text)
        firstStepLabel.text = "1. Write whatever is on your mind"
        
        secondStepLabel.defaultStlye(color: theme.text)
        secondStepLabel.text = "2. Press \"Send To Nowhere\""
        
        thirdStepLabel.defaultStlye(color: theme.text)
        thirdStepLabel.text = "3. Watch it disappear and be done with it"
        
        let stepStackView = UIStackView(arrangedSubviews: [firstStepLabel, secondStepLabel, thirdStepLabel])
        stepStackView.axis = .vertical
        stepStackView.alignment = .center
        stepStackView.distribution = .equalSpacing
        stepStackView.sizeToFit()
        stepStackView.spacing = 8
        
        aboutLabel.defaultStlye(color: theme.text)
        aboutLabel.text = "It's simple. Sometimes you just need to send something off that will never be seen again. Send To Nowhere lets you write, send, and be done. Instead of writing something that everyone will see, write something no one will see."
        
        let aboutStackView = UIStackView(arrangedSubviews: [stepStackView, aboutLabel])
        aboutStackView.axis = .vertical
        aboutStackView.axis = .vertical
        aboutStackView.alignment = .center
        aboutStackView.distribution = .equalSpacing
        aboutStackView.spacing = 48
        aboutStackView.sizeToFit()
        
        view.addSubview(aboutStackView)
        
        aboutStackView.snp.makeConstraints { (make) -> Void in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            } else {
                make.top.equalTo(view).offset(96)
            }
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
        }
        
        alternateThemeToggle.onTintColor = theme.secondary
        alternateThemeToggle.isOn = AppState.sharedInstance.usingAlternateTheme
        alternateThemeToggle.addTarget(self, action: #selector(STNAboutViewController.didToggleAlternateTheme), for: .valueChanged)
        
        aleternateThemeLabel.defaultStlye(color: theme.text)
        aleternateThemeLabel.textAlignment = .left
        aleternateThemeLabel.text = "Use alternate theme"
        aleternateThemeLabel.sizeToFit()
        
        let alternateThemeStack = UIStackView(arrangedSubviews: [aleternateThemeLabel, alternateThemeToggle])
        alternateThemeStack.axis = .horizontal
        alternateThemeStack.distribution = .fillProportionally
        alternateThemeStack.sizeToFit()
        alternateThemeStack.spacing = 8
        
        view.addSubview(alternateThemeStack)
        
        alternateThemeStack.snp.makeConstraints { (make) -> Void in
            if #available(iOS 11, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-60)
            } else {
                make.top.equalTo(view).offset(-80)
            }
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
        }
        
        view.backgroundColor = theme.primary
    }
    
    // MARK: - Actions
    
    @objc func didToggleAlternateTheme(sender: UISwitch!) {
        if sender.isOn {
            AppState.sharedInstance.useAlternateTheme()
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                    UIApplication.shared.setAlternateIconName("alternate_icon")
                }
            }
        } else {
            AppState.sharedInstance.useDefaultTheme()
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                    UIApplication.shared.setAlternateIconName(nil)
                }
            }
        }
        if let parentController = parent as? STNAboutPageViewController {
            parentController.refreshViews()
        }
    }
}
