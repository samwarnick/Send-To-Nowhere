//
//  STNButton.swift
//  Nowhere
//
//  Created by Sam Warnick on 4/6/17.
//  Copyright © 2017 Sam Warnick. All rights reserved.
//

import UIKit

class STNButton: UIButton {
    
    var shadowLayer: UIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let halfOfButtonHeight = layer.frame.height / 2
        layer.cornerRadius = halfOfButtonHeight
        contentEdgeInsets = UIEdgeInsetsMake(10, halfOfButtonHeight, 10, halfOfButtonHeight)
        
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        clipsToBounds = true
        
        applyGradient([UIColor.stnCyan, UIColor.stnRichElectricBlue], locations: nil, startPoint: CGPoint(x: 0.0, y: 0.2), endPoint: CGPoint(x: 1.0, y: 0.8))
    }

    override var isHidden: Bool {
        didSet {
            shadowLayer?.isHidden = isHidden
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            let newOpacity : Float = isHighlighted ? 0.6 : 0.85
            let newRadius : CGFloat = isHighlighted ? 6.0 : 4.0
            
            let shadowOpacityAnimation = CABasicAnimation()
            shadowOpacityAnimation.keyPath = "shadowOpacity"
            shadowOpacityAnimation.fromValue = shadowLayer.layer.shadowOpacity
            shadowOpacityAnimation.toValue = newOpacity
            shadowOpacityAnimation.duration = 0.1
            
            let shadowRadiusAnimation = CABasicAnimation()
            shadowRadiusAnimation.keyPath = "shadowRadius"
            shadowRadiusAnimation.fromValue = shadowLayer.layer.shadowRadius
            shadowRadiusAnimation.toValue = newRadius
            shadowRadiusAnimation.duration = 0.1
            
            shadowLayer.layer.add(shadowOpacityAnimation, forKey: "shadowOpacity")
            shadowLayer.layer.add(shadowRadiusAnimation, forKey: "shadowRadius")
            
            shadowLayer.layer.shadowOpacity = newOpacity
            shadowLayer.layer.shadowRadius = newRadius
            
            let xScale : CGFloat = isHighlighted ? 1.025 : 1.0
            let yScale : CGFloat = isHighlighted ? 1.05 : 1.0
            UIView.animate(withDuration: 0.1) {
                let transformation = CGAffineTransform(scaleX: xScale, y: yScale)
                self.transform = transformation
                self.shadowLayer.transform = transformation
            }
            
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if shadowLayer == nil {
            shadowLayer = UIView(frame: frame)
            superview?.addSubview(shadowLayer)
            superview?.bringSubview(toFront: self)
            
            shadowLayer.backgroundColor = UIColor.clear
            shadowLayer.layer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
            shadowLayer.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.layer.shadowOpacity = 0.85
            shadowLayer.layer.shadowRadius = 4.0
            shadowLayer.layer.masksToBounds = true
            shadowLayer.clipsToBounds = false
            shadowLayer.isHidden = isHidden
        }
    }
}
