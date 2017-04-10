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
                UIView.animate(withDuration: 0.25) {
                    self.textView.snp.updateConstraints { (make) -> Void in
                        make.bottom.equalTo(self.view).offset(-10 - keyboardSize.height)
                    }
                    if (self.textView.contentSize.height < keyboardSize.height) {
                        self.textView.contentInset.top = self.textView.contentInset.top - keyboardSize.height / 2
                    }
                }
                keyboardIsUp = !keyboardIsUp
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardIsUp {
                UIView.animate(withDuration: 0.25) {
                    self.textView.snp.updateConstraints { (make) -> Void in
                        make.bottom.equalTo(self.view).offset(0)
                    }
                    if (self.textView.contentSize.height < keyboardSize.height) {
                        self.textView.contentInset.top = self.textView.contentInset.top + keyboardSize.height / 2
                    }
                }
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
        
        // keyboard toolbar
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(STNMainViewController.didPressDone))
        doneButton.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightThin), NSForegroundColorAttributeName: UIColor.stnRichElectricBlue], for: .normal)
//        let doneButton = UIBarButtonItem(image: UIImage(named: "exit"), style: .done, target: self, action: #selector(STNMainViewController.didPressDone))
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        toolBar.barTintColor = UIColor.white
        toolBar.tintColor = UIColor.stnRichElectricBlue
        textView.inputAccessoryView = toolBar
        
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
        
        let currentText = textView.text as NSString?
        let updatedText = currentText?.replacingCharacters(in: range, with: text)
        
        if (updatedText?.isEmpty)! {
            resetTextView()
            
            return false
        } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
            
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

