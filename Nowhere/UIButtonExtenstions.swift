//
//  UIButtonExtenstions.swift
//  Nowhere
//
//  Created by Sam Warnick on 4/7/17.
//  Copyright © 2017 Sam Warnick. All rights reserved.
//

import UIKit

extension UIButton {
    func defaultStlye(color: UIColor) {
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.thin)
        tintColor = color
    }
}
