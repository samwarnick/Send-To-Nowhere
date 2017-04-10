//
//  STNAboutViewController.swift
//  Nowhere
//
//  Created by Sam Warnick on 4/8/17.
//  Copyright © 2017 Sam Warnick. All rights reserved.
//

import UIKit

class STNAboutViewController: UIViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    func configureViews() {
        let aboutLabel = UILabel()
        aboutLabel.defaultStlye()
        aboutLabel.text = "Just write something and send it off to nowhere. No one will ever see it after it's sent. We don't collect any personal data. Just write, send, and be done."
        
        view.addSubview(aboutLabel)
        aboutLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(view)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
        }
        
        view.backgroundColor = UIColor.white
    }
}
