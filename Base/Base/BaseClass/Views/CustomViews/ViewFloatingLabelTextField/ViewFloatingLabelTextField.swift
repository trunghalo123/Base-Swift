//
//  ViewFloatingLabelTextField.swift
//  Base
//
//  Created by Be More on 2/17/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation
import UIKit

enum FloatingTextFieldStautus {
    case editingDidEnd
    case editingDidBegin
    case editingDidChanged
}

class ViewFloatingLabelTextField: UIView {
    
    @IBOutlet var viewHieght: NSLayoutConstraint?
    
    
    private var commomPlaceholderLabelHeight: CGFloat = 17
    
    var contentViewHeight: CGFloat = 0
    
    /// Change floating label color.
    @IBInspectable var floatingTextColor: UIColor? = .green
    
    private var duration: Double?
    @IBInspectable var amimateDuration: Double  {
        get {
            return self.duration ?? 0
        } set {
            self.duration = newValue
        }
    }
    
   
//    @IBInspectable var floatingTextFont: UIFont = .boldSystemFont(ofSize: 14)
    
    @IBInspectable var placeholder: String = "placeholder" {
        didSet {
            self.floatingLabel.text = placeholder
        }
    }
    
    private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var floatingTextField: UITextField = {
        let textField = UITextField()

        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var floatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var underLineview: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView(frame: self.frame)
    }
    
    private func setUpView(frame: CGRect) {
        self.contentViewHeight = frame.height
        self.addSubview(self.contentView)
        setUpContentViewConstraints(frame: frame)
    }
    
    
    private var contentViewHeightAnchor: NSLayoutConstraint?
    private var contentViewBottom: NSLayoutConstraint?
    
    private func setUpContentViewConstraints(frame: CGRect) {
        self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.contentViewBottom = self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        self.contentViewBottom?.isActive = true
//        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: self.heightAnchor)
        self.contentViewHeightAnchor?.isActive = true
        setUpTextFieldConstraints(frame: frame)
    }
    
    private func setUpTextFieldConstraints(frame: CGRect) {
        self.contentView.addSubview(self.floatingTextField)
        self.contentView.addSubview(self.underLineview)
        [self.floatingTextField.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
        self.floatingTextField.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
        self.floatingTextField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -1), self.floatingTextField.heightAnchor.constraint(equalToConstant: self.contentViewHeight - 1 )].forEach { (constraint) in
            constraint.isActive = true
        }
        self.floatingTextField.addSubview(self.floatingLabel)
        setUpUnderLineViewConstraints()
        setUpTextFieldAction()
        setUpLabelConstraints(frame: frame)
    }
    
    private func setUpUnderLineViewConstraints() {
        [self.underLineview.topAnchor.constraint(equalTo: self.floatingTextField.bottomAnchor),
        self.underLineview.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        self.underLineview.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
        self.underLineview.heightAnchor.constraint(equalToConstant: 1)].forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
    private func setUpTextFieldAction() {
        self.floatingTextField.addTarget(self, action: #selector(floatingLabelEditingChanged), for: .editingChanged)
        self.floatingTextField.addTarget(self, action: #selector(floatingLabelEditingDidEnd), for: .editingDidEnd)
        self.floatingTextField.addTarget(self, action: #selector(floatingLabelEditingDidbegin), for: .editingDidBegin)
    }
    
    
    var floatingLabelCenterY: NSLayoutConstraint?
    private func setUpLabelConstraints(frame: CGRect) {
        [self.floatingLabel.rightAnchor.constraint(equalTo: self.floatingTextField.rightAnchor),
         self.floatingLabel.leftAnchor.constraint(equalTo: self.floatingTextField.leftAnchor),
        self.floatingLabel.heightAnchor.constraint(equalToConstant: self.commomPlaceholderLabelHeight)].forEach { (constraint) in
            constraint.isActive = true
        }
        self.floatingLabelCenterY = self.floatingLabel.centerYAnchor.constraint(equalTo: self.floatingTextField.centerYAnchor)
        self.floatingLabelCenterY?.isActive = true
        floatingLabel.text = placeholder
    }
    
    private func updateFloatingLabel(textFieldStatus: FloatingTextFieldStautus, isActive: Bool) {
        switch textFieldStatus {
        case .editingDidBegin:
            if isActive {
                self.floatingLabelCenterY?.isActive = !isActive
                self.floatingLabelCenterY?.constant -= (self.contentViewHeight / 2 + self.commomPlaceholderLabelHeight / 2)
                self.floatingLabelCenterY?.isActive = isActive
                self.floatingLabel.textColor = self.floatingTextColor
                self.floatingLabel.font = UIFont.boldSystemFont(ofSize: 14)
                self.underLineview.backgroundColor = self.floatingTextColor
            }
        case .editingDidEnd:
            if isActive {
                self.floatingLabelCenterY?.isActive = !isActive
                self.floatingLabelCenterY?.constant += (self.contentViewHeight / 2 + self.commomPlaceholderLabelHeight / 2)
                self.floatingLabelCenterY?.isActive = isActive
                self.floatingLabel.textColor = .lightGray
                self.floatingLabel.font = UIFont.systemFont(ofSize: 15)
                self.underLineview.backgroundColor = .lightGray
            } else {
                
            }
        default:
            break
        }
    }
    
    private func updateViewHeight(changeAmount: CGFloat ,textfieldStatus: FloatingTextFieldStautus, isActive: Bool) {
        switch textfieldStatus {
        case .editingDidBegin:
            if isActive {
                self.viewHieght?.constant += changeAmount
                self.superview?.layoutIfNeeded()
            } else {
               self.viewHieght?.constant += 0
                self.superview?.layoutIfNeeded()
            }
        case .editingDidEnd:
            if isActive {
                self.viewHieght?.constant -= changeAmount
                self.superview?.layoutIfNeeded()
            } else {
                self.viewHieght?.constant -= 0
                self.superview?.layoutIfNeeded()
            }
        default:
            break
        }
    }
    
    @objc private func floatingLabelEditingChanged() {
         UIView.animate(withDuration: amimateDuration) {
             self.floatingLabel.textColor = self.floatingTextColor
             self.floatingLabel.font = UIFont.boldSystemFont(ofSize: 14)
             self.layoutIfNeeded()
             self.superview?.layoutIfNeeded()
         }
     }
     
     @objc private func floatingLabelEditingDidbegin() {
         guard let text = self.floatingTextField.text else {
             return
         }
        if text.isEmpty {
            UIView.animate(withDuration: amimateDuration) {
                // updateViewHeight
                
                self.updateViewHeight(changeAmount: self.commomPlaceholderLabelHeight, textfieldStatus: .editingDidBegin, isActive: true)
                
                // update floating label y constraints
                self.updateFloatingLabel(textFieldStatus: .editingDidBegin, isActive: true)
                self.layoutIfNeeded()
            }
        }
        UIView.animate(withDuration: amimateDuration) {
            self.floatingLabel.font = UIFont.boldSystemFont(ofSize: 14)
            self.floatingLabel.textColor = self.floatingTextColor
            self.layoutIfNeeded()
        }
    }
    
    @objc private func floatingLabelEditingDidEnd() {
        guard let text = self.floatingTextField.text else {
            return
        }
        if text.isEmpty {
            UIView.animate(withDuration: amimateDuration) {
               self.updateViewHeight(changeAmount: self.commomPlaceholderLabelHeight, textfieldStatus: .editingDidEnd, isActive: true)
                
                // update floating label y constraints
                self.updateFloatingLabel(textFieldStatus: .editingDidEnd, isActive: text.isEmpty)
                self.layoutIfNeeded()
            }
        } else {
            self.floatingLabel.textColor = .lightGray
            self.underLineview.backgroundColor = .lightGray
        }
    }
}
