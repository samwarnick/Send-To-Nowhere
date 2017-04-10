//
//  UIViewExtensions.swift
//  Nowhere
//
//  Created by Sam Warnick on 4/6/17.
//  Copyright © 2017 Sam Warnick. All rights reserved.
//

import UIKit

extension UIView {
    func applyGradient(colors: [UIColor]) -> Void {
        applyGradient(colors, locations: nil, startPoint: nil, endPoint: nil)
    }
    
    func applyGradient(_ colors: [UIColor], locations: [NSNumber]?, startPoint: CGPoint?, endPoint: CGPoint?, radius: CGFloat = 0.0) -> Void {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = startPoint ?? CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = endPoint ?? CGPoint(x: 0.5, y: 1.0)
        gradient.cornerRadius = radius
        if let oldGradient = layer.sublayers?[0] as? CAGradientLayer {
            layer.replaceSublayer(oldGradient, with: gradient)
        } else {
            layer.insertSublayer(gradient, below: nil)
        }
    }
    
    func applyBottomBorder(withColor color: UIColor) {
        let line = CALayer()
        
        let height = CGFloat(0.5)
        line.backgroundColor = color.cgColor
        
        line.frame = CGRect(x: 0, y: frame.height - height, width: frame.width, height: height)
        
        layer.addSublayer(line)
    }
    
    func fadeTransition(duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        self.layer.add(animation, forKey: kCATransitionFade)
    }
}
