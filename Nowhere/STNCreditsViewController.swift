//
//  STNCreditsViewController.swift
//  Nowhere
//
//  Created by Sam Warnick on 4/8/17.
//  Copyright © 2017 Sam Warnick. All rights reserved.
//

import UIKit

class STNCreditsViewController: UIViewController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }
    
    func configureViews() {
        let theme = AppState.sharedInstance.currentTheme
        
        let authorLabel = UILabel()
        authorLabel.defaultStlye(color: theme.text)
        authorLabel.text = "Created by Sam Warnick"

        let websiteButton = UIButton(type: .system)
        websiteButton.defaultStlye(color: theme.other)
        websiteButton.setTitle("samwarnick.com", for: .normal)
        websiteButton.addTarget(self, action: #selector(STNCreditsViewController.didPressWebisteButton), for: .touchUpInside)
        websiteButton.sizeToFit()

        let twitterButton = UIButton(type: .system)
        twitterButton.defaultStlye(color: theme.other)
        twitterButton.setTitle("@samwarnick", for: .normal)
        twitterButton.addTarget(self, action: #selector(STNCreditsViewController.didPressTwitterButton), for: .touchUpInside)
        twitterButton.sizeToFit()

        let myDetailsStackView = UIStackView(arrangedSubviews: [authorLabel, websiteButton, twitterButton])
        myDetailsStackView.axis = .vertical
        myDetailsStackView.alignment = .center
        myDetailsStackView.distribution = .equalSpacing
        myDetailsStackView.spacing = 8
        myDetailsStackView.sizeToFit()

        view.addSubview(myDetailsStackView)
        
        myDetailsStackView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(view)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
        }
        
        view.backgroundColor = theme.primary
    }
    
    // MARK: - Actions
    
    @objc func didPressWebisteButton(sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://samwarnick.com")!, options: [UIApplicationOpenURLOptionUniversalLinksOnly: false], completionHandler: nil)
    }
    
    @objc func didPressTwitterButton(sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://twitter.com/samwarnick")!, options: [UIApplicationOpenURLOptionUniversalLinksOnly: false], completionHandler: nil)
    }

}
