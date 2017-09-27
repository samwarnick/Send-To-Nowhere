//
//  STNMainViewController.swift
//  Nowhere
//
//  Created by Sam Warnick on 4/5/17.
//  Copyright © 2017 Sam Warnick. All rights reserved.
//

import UIKit

class STNMainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let textView = STNTextView()
    let sendButton = STNButton()
    var shareButton = UIButton()
    var currentMessage: String?
    private var keyboardIsUp = false
    private var theme = AppState.sharedInstance.currentTheme
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboardListeners()
        configureViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupKeyboardListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(STNMainViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(STNMainViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if !keyboardIsUp {
                textView.contentInset.bottom = keyboardSize.height + 10
                textView.forceCentering(withKeyboardOffset: keyboardSize.height)
                
                keyboardIsUp = !keyboardIsUp
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue != nil {
            if keyboardIsUp {
                textView.contentInset.bottom = 120
                textView.forceCentering(withKeyboardOffset: 0)
                
                keyboardIsUp = !keyboardIsUp
            }
        }
    }
    
    func configureViews() {
        
        theme = AppState.sharedInstance.currentTheme
        
        // text view
        view.addSubview(textView)
        
        textView.delegate = self
        
        textView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view).offset(0)
            make.left.equalTo(view).offset(20)
            make.bottom.equalTo(view).offset(0)
            make.right.equalTo(view).offset(-20)
        }
        
        textView.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.thin)
        textView.keyboardDismissMode = .interactive
        textView.textAlignment = .center
        textView.showsVerticalScrollIndicator = false
        textView.tintColor = theme.secondary
        textView.returnKeyType = .done
        textView.contentInset.bottom = 120
        textView.backgroundColor = theme.primary
        
        // buttons
        
        sendButton.setTitle("Send To Nowhere", for: .normal)
        sendButton.addTarget(self, action: #selector(STNMainViewController.didPressSendToNowhereButton), for: .touchUpInside)
        sendButton.isHidden = true
        
        view.addSubview(sendButton)
        
        sendButton.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-60)
        }
        
        shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.tintColor = UIColor.stnColumbiaBlue
        shareButton.addTarget(self, action: #selector(STNMainViewController.didPressShareButton), for: .touchUpInside)
        
        view.addSubview(shareButton)
        
        shareButton.snp.makeConstraints{ (make) -> Void in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            } else {
                make.top.equalTo(view).offset(30)
            }
            make.left.equalTo(view).offset(20)
        }
        
        shareButton.isHidden = true
        
        let aboutButton = UIButton(type: .system)
        aboutButton.setImage(UIImage(named: "cog"), for: .normal)
        aboutButton.tintColor = UIColor.stnColumbiaBlue
        aboutButton.addTarget(self, action: #selector(STNMainViewController.didPressAboutButton), for: .touchUpInside)
        
        view.addSubview(aboutButton)
        
        aboutButton.snp.makeConstraints{ (make) -> Void in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            } else {
                make.top.equalTo(view).offset(30)
            }
            make.right.equalTo(view).offset(-20)
        }
        
        // view
        
        view.backgroundColor = theme.primary
        resetTextView()
    }
    
    func resetTextView() {
        textView.text = currentMessage != nil && currentMessage != "" ? currentMessage : "Type something."
        textView.textColor = currentMessage != nil && currentMessage != "" ? theme.text : theme.placeholder
        
        textView.selectedTextRange = self.textView.textRange(from: self.textView.beginningOfDocument, to: self.textView.beginningOfDocument)
        textView.canPerformActions = false
        
        sendButton.isHidden = true
        shareButton.fadeTransition(duration: 0.25)
        shareButton.isHidden = true
    }
    
    // MARK: - Actions
    
    func didPressDone() {
        textView.endEditing(true)
    }
    
    @objc func didPressSendToNowhereButton(sender: UIButton) {
        let nextViewController = STNSendingViewController()
        nextViewController.modalPresentationStyle = .custom
        nextViewController.modalTransitionStyle = .crossDissolve
        present(nextViewController, animated: true) {
            self.currentMessage = ""
            self.resetTextView()
        }
    }
    
    @objc func didPressAboutButton(sender: UIButton) {
        let nextViewController = STNAboutPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        nextViewController.modalPresentationStyle = .custom
        nextViewController.modalTransitionStyle = .crossDissolve
        present(nextViewController, animated: true, completion: nil)
    }
    
    @objc func didPressShareButton(sender: UIBarButtonItem) {
        guard let text = currentMessage else {
            return
        }
        
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        present(activityViewController, animated: true, completion: nil)
    }

}

extension STNMainViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        let currentText = textView.text as NSString?
        let updatedText = currentText?.replacingCharacters(in: range, with: text)
        
        if (updatedText?.isEmpty)! {
            resetTextView()
            
            return false
        } else if textView.textColor == theme.placeholder && !text.isEmpty {
            textView.text = nil
            textView.textColor = theme.text
            (textView as! STNTextView).canPerformActions = true
            
            sendButton.isHidden = false
            shareButton.fadeTransition(duration: 0.25)
            shareButton.isHidden = false
        }
        
        currentMessage = updatedText
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == theme.placeholder {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}

