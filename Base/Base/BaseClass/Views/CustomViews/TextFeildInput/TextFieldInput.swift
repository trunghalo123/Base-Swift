//
//  TextFieldInput.swift
//  Base
//
//  Created by Be More on 2/11/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation
import UIKit

class TextFieldInput: UITextField {
    @IBInspectable var imageSize: CGFloat = 24
    @IBInspectable var imageMarginIn: CGFloat = 8
    @IBInspectable var imageMarginOut: CGFloat = 0
    @IBInspectable var imagePadding: CGFloat = 0
    @IBInspectable var lineMargin: CGFloat = 0 {
        didSet {
            self.bottomLine.frame = CGRect(x: lineMargin, y: height - lineHeight, width: width - 2 * lineMargin, height: lineHeight)
        }
    }
    @IBInspectable var lineHeight: CGFloat = 1 {
        didSet {
            self.bottomLine.frame = CGRect(x: lineMargin, y: height - lineHeight, width: width - 2 * lineMargin, height: lineHeight)
        }
    }
    @IBInspectable var lineColor: UIColor? = .lightGray {
        didSet {
            if !self.isEditing {
                self.bottomLine.backgroundColor = lineColor
            }
        }
    }
    @IBInspectable var selectedLineColor: UIColor? = .green {
        didSet {
            if self.isEditing {
                self.bottomLine.backgroundColor = selectedLineColor
            }
        }
    }
    @IBInspectable var leftImage: UIImage? {
        willSet {
            if let newValue = newValue {
                self.addImage(direction: .left,
                              image: newValue,
                              marginIn: imageMarginIn,
                              marginOut: imageMarginOut,
                              padding: imagePadding)
            } else {
                self.leftView = nil
            }
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        willSet {
            if let newValue = newValue {
                self.addImage(direction: .right,
                              image: newValue,
                              marginIn: imageMarginIn,
                              marginOut: imageMarginOut,
                              padding: imagePadding)
            } else {
                self.rightView = nil
            }
        }
    }
    
    var leftImageAction: (()->Void)?
    var rightImageAction: (()->Void)?
    
    lazy var bottomLine: UIView = {
        let viewBottomLine = UIView(frame: CGRect(x: lineMargin, y: height - lineHeight, width: width - 2 * lineMargin, height: lineHeight))
        viewBottomLine.backgroundColor = .gray
        return viewBottomLine
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bottomLine.frame = CGRect(x: lineMargin, y: height - lineHeight, width: width - 2 * lineMargin, height: lineHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        self.addSubview(bottomLine)
        self.addTarget(self, action: #selector(self.editingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.editingDidEnd), for: .editingDidEnd)
    }
    
    func addImage(direction: ImageDirection, image: UIImage?, marginIn: CGFloat, marginOut: CGFloat, padding: CGFloat){
        
        if(direction == ImageDirection.left){ // image left
            let view = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: imageSize + marginIn + marginOut,
                                            height: height))
            view.backgroundColor = .clear
            
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: padding + marginOut,
                                     y: (height - imageSize) / 2.0,
                                     width: imageSize - padding * 2,
                                     height: imageSize - padding * 2)
            view.addSubview(imageView)
            
            self.leftViewMode = .always
            self.leftView = view
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.touchLeftImage(_:))))
        } else { // image right
            let view = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: imageSize + marginIn + marginOut,
                                            height: height))
            view.backgroundColor = .clear
            
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: padding + marginIn,
                                     y: (height - imageSize) / 2.0,
                                     width: imageSize - padding * 2,
                                     height: imageSize - padding * 2)
            view.addSubview(imageView)
            
            self.rightViewMode = .always
            self.rightView = view
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.touchRightImage(_:))))
        }
    }
    
    @objc func editingDidBegin() {
        UIView.animate(withDuration: 0.2) {
            self.bottomLine.backgroundColor = self.selectedLineColor
        }
    }
    
    @objc func editingDidEnd() {
        UIView.animate(withDuration: 0.2) {
            self.bottomLine.backgroundColor = self.lineColor
        }
    }
    
    @objc func touchLeftImage(_ sender: UITapGestureRecognizer) {
        self.leftImageAction?()
    }
    
    @objc func touchRightImage(_ sender: UITapGestureRecognizer) {
        self.rightImageAction?()
    }
}

/// Call delegate to change top constraints
protocol ChangeTopConstrain {
    func changeTopConstrain(textField: FloatingLabelTextField,constraint: CGFloat)
}

// MARK: - Floating label
class FloatingLabelTextField: TextFieldInput {
   
    private var floatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    var isUsingFloatingLabel: Bool = false
    
    /// Enable floating label
    @IBInspectable var enableFloatingLabel: Bool {
        get {
            return isUsingFloatingLabel
        } set {
            addFloatingLabel(needUse: newValue)
        }
    }
    
    private var floatingLabelTopConstrain: NSLayoutConstraint?
    
    private func addFloatingLabel(needUse: Bool) {
        self.addSubview(self.floatingLabel)
        if needUse {
            self.floatingLabel.text = self.placeholder
        
            self.placeholder = ""
        }
        self.floatingLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = needUse
        self.floatingLabelTopConstrain = floatingLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 6)
        self.floatingLabelTopConstrain?.isActive = needUse
        self.floatingLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = needUse
        self.floatingLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -12).isActive = needUse
        self.addTarget(self, action: #selector(floatingLabelEditingChanged), for: .editingChanged)
        self.addTarget(self, action: #selector(floatingLabelEditingDidEnd), for: .editingDidEnd)
        self.addTarget(self, action: #selector(floatingLabelEditingChanged), for: .editingDidBegin)
        
    }
    
    @objc private func floatingLabelEditingChanged() {
        UIView.animate(withDuration: 0.2) {
            self.floatingLabelTopConstrain?.isActive = false
            self.floatingLabelTopConstrain?.constant = -(self.height - 12 + 5)
            self.floatingLabelTopConstrain?.isActive = true
            self.floatingLabel.font = UIFont.boldSystemFont(ofSize: 14)
            self.floatingLabel.textColor = .green
            self.layoutIfNeeded()
        }
    }
    
    @objc private func floatingLabelEditingDidEnd() {
        guard let text = self.text else {
            return
        }
        if text.isEmpty {
            UIView.animate(withDuration: 0.2) {
                self.floatingLabelTopConstrain?.isActive = false
                self.floatingLabelTopConstrain?.constant = 6
                self.floatingLabelTopConstrain?.isActive = true
                self.floatingLabel.font = UIFont.systemFont(ofSize: 17)
                self.floatingLabel.textColor = .lightGray
                self.layoutIfNeeded()
            }
        } else {
            self.floatingLabel.textColor = .lightGray
        }
    }
}
