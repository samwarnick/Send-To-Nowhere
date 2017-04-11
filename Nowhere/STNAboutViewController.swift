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
        
//        let scrollView = UIScrollView()
//        scrollView.showsVerticalScrollIndicator = false
        
        let firstStepLabel = UILabel()
        firstStepLabel.defaultStlye()
        firstStepLabel.text = "1. Write whatever is on your mind"
        
        let secondStepLabel = UILabel()
        secondStepLabel.defaultStlye()
        secondStepLabel.text = "2. Press \"Send To Nowhere\""
        
        let thirdStepLabel = UILabel()
        thirdStepLabel.defaultStlye()
        thirdStepLabel.text = "3. Watch it disappear and be done with it"
        
        let stepStackView = UIStackView(arrangedSubviews: [firstStepLabel, secondStepLabel, thirdStepLabel])
        stepStackView.axis = .vertical
        stepStackView.alignment = .center
        stepStackView.distribution = .equalSpacing
        stepStackView.sizeToFit()
        stepStackView.spacing = 8
        
        let aboutLabel = UILabel()
        aboutLabel.defaultStlye()
        aboutLabel.text = "It's simple. Sometimes you just need to send something off that will never be seen again. Send To Nowhere lets you write, send, and be done. Instead of writing something that everyone will see, write something no one will see."
        
        let aboutStackView = UIStackView(arrangedSubviews: [stepStackView, aboutLabel])
        aboutStackView.axis = .vertical
        aboutStackView.axis = .vertical
        aboutStackView.alignment = .center
        aboutStackView.distribution = .equalSpacing
        aboutStackView.spacing = 24
        aboutStackView.sizeToFit()
        
        view.addSubview(aboutStackView)
        aboutStackView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(view)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
        }
        
        view.backgroundColor = UIColor.white
    }
}
