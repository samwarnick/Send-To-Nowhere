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
    private var keyboardIsUp = false
    
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
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if !keyboardIsUp {
                textView.contentInset.bottom = keyboardSize.height + 10
                textView.forceCentering(withKeyboardOffset: keyboardSize.height)
                
                keyboardIsUp = !keyboardIsUp
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue != nil {
            if keyboardIsUp {
                textView.contentInset.bottom = 120
                textView.forceCentering(withKeyboardOffset: 0)
                
                keyboardIsUp = !keyboardIsUp
            }
        }
    }
    
    private func configureViews() {
        
        // text view
        view.addSubview(textView)
        
        textView.delegate = self
        
        textView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view).offset(0)
            make.left.equalTo(view).offset(20)
            make.bottom.equalTo(view).offset(0)
            make.right.equalTo(view).offset(-20)
        }
        
        textView.font = UIFont.systemFont(ofSize: 36, weight: UIFontWeightThin)
        textView.keyboardDismissMode = .interactive
        textView.textAlignment = .center
        textView.showsVerticalScrollIndicator = false
        textView.tintColor = UIColor.stnRichElectricBlue
        textView.returnKeyType = .done
        textView.contentInset.bottom = 120
        
        // buttons
        
        sendButton.setTitle("Send To Nowhere", for: .normal)
        sendButton.addTarget(self, action: #selector(STNMainViewController.didPressSendToNowhereButton), for: .touchUpInside)
        sendButton.isHidden = true
        
        view.addSubview(sendButton)
        
        sendButton.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-60)
        }
        
        let aboutButton = UIButton(type: .infoLight)
        aboutButton.tintColor = UIColor.stnColumbiaBlue
        aboutButton.addTarget(self, action: #selector(STNMainViewController.didPressAboutButton), for: .touchUpInside)
        
        view.addSubview(aboutButton)
        
        aboutButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-15)
        }
        
        // status bar background
        
        let statusBarBackground = UIView()
        statusBarBackground.frame = UIApplication.shared.statusBarFrame
        statusBarBackground.backgroundColor = UIColor.white
        
        view.addSubview(statusBarBackground)
        
        // view
        
        view.backgroundColor = UIColor.white
        resetTextView()
    }
    
    func resetTextView() {
        textView.text = "Type something."
        textView.textColor = UIColor.lightGray
        
        textView.selectedTextRange = self.textView.textRange(from: self.textView.beginningOfDocument, to: self.textView.beginningOfDocument)
        textView.canPerformActions = false
        
        sendButton.isHidden = true
    }
    
    // MARK: - Actions
    
    func didPressDone() {
        textView.endEditing(true)
    }
    
    func didPressSendToNowhereButton(sender: UIButton) {
        let nextViewController = STNSendingViewController()
        nextViewController.modalPresentationStyle = .custom
        nextViewController.modalTransitionStyle = .crossDissolve
        present(nextViewController, animated: true, completion: { _ in
            self.resetTextView()
        })
    }
    
    func didPressAboutButton(sender: UIButton) {
        let nextViewController = STNAboutPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        nextViewController.modalPresentationStyle = .custom
        nextViewController.modalTransitionStyle = .crossDissolve
        present(nextViewController, animated: true, completion: nil)
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
        } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
            (textView as! STNTextView).canPerformActions = true
            
            sendButton.isHidden = false
        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}

