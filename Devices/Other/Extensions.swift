//
//  Extensions.swift
//  Devices
//
//  Created by iMac on 26.08.2021.
//

import UIKit

extension UILabel {
    
    func getSize(constrainedWidth: CGFloat) -> CGSize {
        
        return systemLayoutSizeFitting(
            CGSize(width: constrainedWidth,
                   height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel)
    }
    
    func getSize(constrainedHeight: CGFloat) -> CGSize {
        
        return systemLayoutSizeFitting(
            CGSize(width: UIView.layoutFittingExpandedSize.width,
                   height: constrainedHeight),
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required)
    }
}

extension UIView {
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}

extension UIView {
    
    private static let kRotationAnimationKey = "rotationanimationkey"

    func rotate(duration: Double = 1) {
        
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

            rotationAnimation.fromValue   = 0.0
            rotationAnimation.toValue     = Float.pi * 2.0
            rotationAnimation.duration    = duration
            rotationAnimation.repeatCount = Float.infinity

            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }

    
    func stopRotating() {
        
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}



extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
