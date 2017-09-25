//
//  UILabelExtensions.swift
//  Nowhere
//
//  Created by Sam Warnick on 4/7/17.
//  Copyright © 2017 Sam Warnick. All rights reserved.
//

import UIKit

extension UILabel {
    func defaultStlye() {
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.thin)
        numberOfLines = 0
    }
}
