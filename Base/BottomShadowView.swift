//
//  BottomShadowView.swift
//  Base
//
//  Created by Be More on 12/31/19.
//  Copyright © 2019 Yami No Mid. All rights reserved.
//

import Foundation
import UIKit



class BottomShadowView: GradientView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.roundCorner = 10
        self.shadow = true
    }
}

class GradientView: UIView {
    
    var isShadow = false 
    @IBInspectable var shadow: Bool {
        get {
            return isShadow
        } set {
            if newValue {
                self.applyShadowDirection(color: .blue, opacity: 1, radius: 10, offset: 10, direction: .bottomRight)
            } else {
                self.removeShadowFromView()
            }
            self.isShadow = newValue
        }
    }
    
    
    @IBInspectable var roundCorner: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    

    var isGradient = false
    @IBInspectable var gradient: Bool {
        set {
            if newValue {
                self.applyGradientBackground(colors: .red, .blue, direction: .bottomLeftToTopRight)
            } else {
                self.removeAllGradientLayer()
            }
        } get {
            return self.isGradient
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.roundCorner = 10
        self.gradient = true
        self.shadow = true
    }
}

class GradientButton: UIButton {
    
    var isCornerRadius = false
    @IBInspectable var corneradius: Bool {
        get {
             return isCornerRadius
        } set {
            if newValue {
                self.applyCornerRadius(radius: 12)
            }
            self.isCornerRadius = newValue
        }
    }
    
    override var bounds: CGRect {
        get {
            return super.bounds
        } set {
            super.bounds = newValue
            addGradientToButton()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGradientToButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addGradientToButton()
    }
    
    private func addGradientToButton() {
        self.removeAllGradientLayer()
        // add gradient
        self.applyGradientBackground(colors: .black, .blue)
        self.applyCornerRadius(radius: 12)
        self.corneradius = true
        self.clipsToBounds = true
    }
}
