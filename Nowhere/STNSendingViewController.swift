//
//  STNSendingViewController.swift
//  Nowhere
//
//  Created by Sam Warnick on 4/6/17.
//  Copyright © 2017 Sam Warnick. All rights reserved.
//

import UIKit
import SnapKit

class STNSendingViewController: UIViewController {

    // MARK: - Properties
    
    private let theme = AppState.sharedInstance.currentTheme
    
    var progressIndicator = STNCircularLoaderView()
    let message = UILabel()
    let doneButton = STNButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(STNSendingViewController.startProgress), userInfo: nil, repeats: false)
    }
    
    func configureViews() {
        
        view.addSubview(progressIndicator)
        progressIndicator.setColor(theme.secondary)
        progressIndicator.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        
        view.addSubview(message)
        
        message.text = "Sent nowhere."
        message.textColor = theme.text
        message.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.thin)
        message.textAlignment = .center
        message.numberOfLines = 0
        message.isHidden = true
        
        message.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(STNSendingViewController.didPressDoneButton), for: .touchUpInside)
        doneButton.isHidden = true
        
        view.addSubview(doneButton)
        
        doneButton.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-60)
        }
        
        view.backgroundColor = theme.primary
    }
    
    @objc func startProgress() {
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(STNSendingViewController.progress), userInfo: nil, repeats: true)
    }
    
    @objc func progress(timer: Timer) {
        let currentProgress = progressIndicator.progress
        let additionalProgress = CGFloat(arc4random_uniform(20)) / 100.0
        let newProgress = min(1, currentProgress + additionalProgress)
        if newProgress >= 1 {
            timer.invalidate()
            Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(STNSendingViewController.progressDone), userInfo: nil, repeats: false)
        }
        progressIndicator.progress = newProgress
    }
    
    @objc func progressDone() {
        UIView.animate(withDuration: 0.3) {
            self.progressIndicator.isHidden = true
            self.message.isHidden = false
            self.doneButton.isHidden = false
            self.progressIndicator.fadeTransition(duration: 0.3)
            self.doneButton.fadeTransition(duration: 0.3)
            self.message.fadeTransition(duration: 0.3)
        }
    }
    
    // MARK: - Actions
    
    @objc func didPressDoneButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
