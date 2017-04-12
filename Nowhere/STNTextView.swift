//
//  STNTextView.swift
//  Nowhere
//
//  Created by Sam Warnick on 4/5/17.
//  Copyright © 2017 Sam Warnick. All rights reserved.
//

import UIKit

class STNTextView: UITextView {
    
    var keyboardOffset : CGFloat = 0
    var canPerformActions = false

    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - keyboardOffset - contentSize.height) / 2
            
            topCorrection = max(20, topCorrection)
            contentInset.top = topCorrection
        }
    }
    
    func forceCentering(withKeyboardOffset newKeyboardOffset: CGFloat) {
        keyboardOffset = newKeyboardOffset
        contentSize = CGSize(width: contentSize.width, height: contentSize.height)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(STNTextView.select) || action == #selector(STNTextView.selectAll) {
            return canPerformActions
        }
        return super.canPerformAction(action, withSender: sender)
    }

}
