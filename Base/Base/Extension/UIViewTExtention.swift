//
//  UIViewTExtention.swift
//  Base
//
//  Created by Be More on 12/16/19.
//  Copyright © 2019 Yami No Mid. All rights reserved.
//

import UIKit

// MARK: - get and set UIView x, y, width, height
extension UIView {
    /// view width
    var width: CGFloat {
        get {
            return self.frame.size.width // point to size so we can set the width
        } set {
            self.frame.size.width = newValue
        }
    }
    
    /// view height
    var height: CGFloat {
        get {
            return self.frame.size.height
        } set {
            self.frame.size.height = newValue
        }
    }
    
    /// view size
    var size: CGSize {
        get {
            return self.frame.size
        } set {
            self.frame.size = newValue
        }
    }
    
    /// origin
    var origin: CGPoint {
        get {
            return self.frame.origin
        } set {
            self.frame.origin = newValue
        }
    }
    
    /// view x
    var x: CGFloat {
        get {
            return self.frame.origin.x
        } set {
            self.frame.origin.x = newValue
        }
    }
    
    /// view y
    var y: CGFloat {
        get {
            return self.frame.origin.y
        } set {
            self.frame.origin.y = newValue
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return self.center.x
        } set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return self.center.y
        } set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    /// get and set top constraint
    var top: CGFloat {
        get {
            return self.frame.origin.y
        } set {
            self.frame.origin.y = newValue
        }
    }
    
    /// get and set bottom constraint
    var bottom: CGFloat {
        get {
            return (UIScreen.main.bounds.height - (self.frame.origin.y + self.frame.size.height))
        } set {
            self.frame.origin.y = UIScreen.main.bounds.height - (newValue + self.frame.size.height)
        }
    }
    
    /// get and set leading constraint
    var leading: CGFloat {
        get {
            return self.frame.origin.x
        } set {
            self.frame.origin.x = newValue
        }
    }
    
    /// get and set trailing constraint
    var trailing: CGFloat {
        get {
            return (UIScreen.main.bounds.width - (self.frame.origin.x + self.frame.size.width))
        } set {
            self.frame.origin.x = UIScreen.main.bounds.width - (newValue + self.frame.size.width)
        }
    }
}


// MARK: - gradient view
extension UIView {
    enum GradientDirection {
        case topToBottom, bottomToTop, leftToRight, rightToLeft
        case topRightToBottomLeft, topLeftToBottomRight, bottomRightTotopLeft, bottomLeftToTopRight
    }
    
    func applyGradientBackground(colors: UIColor..., direction: GradientDirection = .bottomToTop) {
        var cgColor = [CGColor]()
        for color in colors {
            cgColor.append(color.cgColor)
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = cgColor
        gradientLayer.frame = self.bounds
        
        switch direction {
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        case .topLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        case .topRightToBottomLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        case .bottomLeftToTopRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        case .bottomRightTotopLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        default:
            gradientLayer.locations = [0, 1]
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}


// MARK: - round corner
extension UIView {
    func applyCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func applyRoundCorner(corner: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func applyCircleView() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2
        self.layer.masksToBounds = true
    }
}

// MARK: - Shadow
extension UIView {
    
    enum ShadowDirection {
        case top, left, bottom, right
        case topLeft, topRight, bottomLeft, bottomRight
        case none
    }
    
    func applyShadow(color: UIColor = .black, opacity: Float = 1, radius: CGFloat, offset: CGFloat = 2) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = CGSize(width: offset, height: offset)
        self.layer.masksToBounds = false
    }
    
    func applyShadowDirection(color: UIColor = .black, opacity: Float = 1, radius: CGFloat, offset: CGFloat, direction: ShadowDirection = .bottomRight) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        
        switch direction {
        case .top:
            self.layer.shadowOffset = CGSize(width: 0, height: -offset)
        case .left:
            self.layer.shadowOffset = CGSize(width: -offset, height: 0)
        case .right:
            self.layer.shadowOffset = CGSize(width: offset, height: 0)
        case .bottom:
            self.layer.shadowOffset = CGSize(width: 0, height: offset)
        case .topLeft:
            self.layer.shadowOffset = CGSize(width: -offset, height: -offset)
        case .topRight:
            self.layer.shadowOffset = CGSize(width: offset, height: -offset)
        case .bottomLeft:
            self.layer.shadowOffset = CGSize(width: -offset, height: offset)
        case .none:
            self.layer.shadowOffset = .zero
        default:
            self.layer.shadowOffset = CGSize(width: offset, height: offset)
        }
        self.layer.masksToBounds = false
    }
    
    func removeShadowFromView() {
        self.layer.shadowOpacity = 0
    }
}

// MARK: - Add line to view
extension UIView {
    enum LinePosition {
        case top
        case bottom
    }
    
    func addLineToView(color: UIColor = .lightGray, height: Float = 1, position: LinePosition = .bottom) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)
        
        let metrics = ["height": NSNumber(value: height)]
        let view = ["lineView": lineView]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", metrics: metrics, views: view))
        
        switch position {
        case .top:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(height)]", metrics: metrics, views: view))
        default:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(height)]|", metrics: metrics, views: view))
        }
    }
}

// MARK: - Border View
extension UIView {
    enum BorderPosition {
        case top, left, right, bottom
    }
    
    func applyBorder(color: UIColor, width: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func applyBorderPosition(color: UIColor, thicknessOfBorder: CGFloat, edge: BorderPosition) {
        DispatchQueue.main.async {
            var rect: CGRect = CGRect.zero
            switch edge {
            case .top:
                rect = CGRect(x: 0, y: 0, width: self.width, height: thicknessOfBorder)
            case .left:
                rect = CGRect(x: 0, y: 0, width: thicknessOfBorder, height: self.width)
            case .bottom:
                rect = CGRect(x: 0, y: self.height - thicknessOfBorder, width: self.width, height: thicknessOfBorder)
            case .right:
                rect = CGRect(x: self.width - thicknessOfBorder, y: 0, width: thicknessOfBorder, height: self.height)
            }
            
            let layerBorder = CALayer()
            layerBorder.frame = rect
            layerBorder.backgroundColor = color.cgColor
            self.layer.addSublayer(layerBorder)
        }
    }
}

// MARK: - Remove all layer and gradiant layer
extension UIView {
    func removeAllLayer() {
        self.layer.sublayers?.forEach({ (layer) in
            layer.removeFromSuperlayer()
        })
    }
    
    func removeAllGradientLayer() {
        self.layer.sublayers?.forEach({ (layer) in
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        })
    }
}

// MARK: - Rotate view
extension UIView {
    
    func rotate(angle: CGFloat) {
        let radians = angle * .pi / 180.0
        self.transform = self.transform.rotated(by: radians)
    }
    
    func rotateWithAnimation(angle: CGFloat, duration: TimeInterval = 0) {
        let radians = angle * .pi / 180
        UIView.animate(withDuration: duration) {
            self.transform = self.transform.rotated(by: radians)
        }
    }
    
    func animateVibrate() {
        let duration = 0.05
        UIView.animate(withDuration: duration, animations: {
            self.transform = self.transform.translatedBy(x: 5, y: 0)
        }) { (finish) in
            UIView.animate(withDuration: duration, animations: {
                self.transform = self.transform.translatedBy(x: -10, y: 0)
            }) { (finish) in
                UIView.animate(withDuration: duration, animations: {
                    self.transform = self.transform.translatedBy(x: 10, y: 0)
                }) { (finish) in
                    UIView.animate(withDuration: duration, animations: {
                        self.transform = self.transform.translatedBy(x: -10, y: 0)
                    }) { (finish) in
                        UIView.animate(withDuration: duration) {
                            self.transform = CGAffineTransform.identity
                        }
                    }
                }
            }
        }
    }
}
