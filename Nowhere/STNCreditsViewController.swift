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
        let authorLabel = UILabel()
        authorLabel.defaultStlye()
        authorLabel.text = "Created by Sam Warnick"

        let websiteButton = UIButton(type: .system)
        websiteButton.defaultStlye()
        websiteButton.setTitle("samwarnick.com", for: .normal)
        websiteButton.addTarget(self, action: #selector(STNCreditsViewController.didPressWebisteButton), for: .touchUpInside)
        websiteButton.sizeToFit()

        let twitterButton = UIButton(type: .system)
        twitterButton.defaultStlye()
        twitterButton.setTitle("@samwarnick", for: .normal)
        twitterButton.addTarget(self, action: #selector(STNCreditsViewController.didPressTwitterButton), for: .touchUpInside)
        twitterButton.sizeToFit()
        
        let contactLabel = UILabel()
        contactLabel.defaultStlye()
        contactLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        contactLabel.text = "Please get in touch on Twitter with any feedback"

        let myDetailsStackView = UIStackView(arrangedSubviews: [authorLabel, websiteButton, twitterButton, contactLabel])
        myDetailsStackView.axis = .vertical
        myDetailsStackView.alignment = .center

        myDetailsStackView.sizeToFit()

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
        
        view.backgroundColor = UIColor.white
    }
    
    // MARK: - Actions
    
    func didPressWebisteButton(sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://samwarnick.com")!, options: [UIApplicationOpenURLOptionUniversalLinksOnly: false], completionHandler: nil)
    }
    
    func didPressTwitterButton(sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://twitter.com/samwarnick")!, options: [UIApplicationOpenURLOptionUniversalLinksOnly: false], completionHandler: nil)
    }

}
