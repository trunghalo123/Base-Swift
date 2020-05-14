//
//  ViewController.swift
//  Base
//
//  Created by Be More on 12/16/19.
//  Copyright © 2019 Yami No Mid. All rights reserved.
//

import UIKit
import UIFloatLabelTextView

@IBDesignable
class RoundButton: UIButton {
    
   
    @IBInspectable var roundCorner: CGFloat  {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
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
    
    func setCornerRadius(value: CGFloat) {
        self.layer.cornerRadius = value
    }
    
    func commonInit() {
        self.roundCorner = 15
    }
}

class ViewController: UIViewController {
   
    
    @IBOutlet weak var height: NSLayoutConstraint!
    
    let upperLayer = CAShapeLayer()
    
    @IBOutlet weak var viewFloating: ViewFloatingLabelTextField!
    
    @IBOutlet weak var viewN: GradientView!
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
//        self.viewN.backgroundColor = .black
//        self.viewN.bounds = CGRect(x: 10, y: 10, width: 10, height: 10)
//        self.viewN.clipsToBounds = true
        
        self.viewN.addLineToView()
        self.viewN.applyBorderPosition(color: .red, thicknessOfBorder: 10, edge: .top)
//
//        self.viewN.translatesAutoresizingMaskIntoConstraints = false
//        self.viewN.width = 100
//        print(self.viewN.width)
//        print(self.viewN.frame.width)
//
//        self.viewN.centerX = 10
//        print(self.viewN.frame.origin.x)
//        print(self.viewN.frame)
//        print(self.viewN.bounds)
//        self.viewN.addGradientBackground(colors: .red, .blue, direction: .leftToRight)
        
       
        
        let bezier = UIBezierPath(arcCenter: self.view.center, radius: 100, startAngle: -.pi / 2, endAngle: 2 * .pi, clockwise: true)
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.lineWidth = 10
        layer.lineCap = .round
        layer.borderColor = UIColor.lightGray.cgColor
        layer.path = bezier.cgPath
//        self.view.layer.addSublayer(layer)
        
        
        let upperBezier = UIBezierPath(arcCenter: self.view.center, radius: 100, startAngle: -.pi / 2, endAngle: 2 * .pi, clockwise: true)
        upperLayer.fillColor = UIColor.clear.cgColor
        upperLayer.strokeColor = UIColor.red.cgColor
        upperLayer.lineWidth = 10
        upperLayer.lineCap = .round
        upperLayer.borderColor = UIColor.lightGray.cgColor
        upperLayer.path = upperBezier.cgPath
        upperLayer.strokeEnd = 0
//        self.view.layer.addSublayer(upperLayer)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchView)))
    }
    
    @objc func touchView() {
        //        self.someTextField.resignFirstResponder()
        let basicAmnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAmnimation.toValue = 1
        basicAmnimation.duration = 2
        basicAmnimation.repeatCount = 1
        basicAmnimation.fillMode = .backwards
        basicAmnimation.isRemovedOnCompletion = true
        self.viewN.rotateWithAnimation(angle: 15)
        //        self.viewN.animateVibrate()
        self.upperLayer.add(basicAmnimation, forKey: "something")
    
        self.viewFloating.floatingTextField.resignFirstResponder()
    }
}



enum placeholderDirection: String {
    case placeholderUp = "up"
    case placeholderDown = "down"

}
public class IuFloatingTextFiledPlaceHolder: UITextField {
    var enableMaterialPlaceHolder : Bool = true
    var placeholderAttributes = NSDictionary()
    var lblPlaceHolder = UILabel()
    var defaultFont = UIFont()
    var difference: CGFloat = 22.0
    var directionMaterial = placeholderDirection.placeholderUp
    var isUnderLineAvailabe : Bool = true
    override init(frame: CGRect) {
        super.init(frame: frame)
        Initialize ()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Initialize ()
    }
    func Initialize(){
        self.clipsToBounds = false
        self.addTarget(self, action: #selector(IuFloatingTextFiledPlaceHolder.textFieldDidChange), for: .editingChanged)
        self.EnableMaterialPlaceHolder(enableMaterialPlaceHolder: true)
        if isUnderLineAvailabe {
            let underLine = UIImageView()
            underLine.backgroundColor = UIColor.init(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 0.8)
            //            underLine.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)
            underLine.frame = CGRect(x: 0, y: self.frame.size.height-1, width : self.frame.size.width, height : 1)

            underLine.clipsToBounds = true
            self.addSubview(underLine)
        }
        defaultFont = self.font!

    }
    @IBInspectable var placeHolderColor: UIColor? = UIColor.lightGray {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder! as String ,
                                                            attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor!])
        }
    }
    override public var placeholder:String?  {
        didSet {
            //  NSLog("placeholder = \(placeholder)")
        }
        willSet {
            let atts  = [NSAttributedString.Key.foregroundColor.rawValue: UIColor.lightGray, NSAttributedString.Key.font: UIFont.labelFontSize] as! [NSAttributedString.Key : Any]
            self.attributedPlaceholder = NSAttributedString(string: newValue!, attributes:atts)
            self.EnableMaterialPlaceHolder(enableMaterialPlaceHolder: self.enableMaterialPlaceHolder)
        }

    }
    override public var attributedText:NSAttributedString?  {
        didSet {
            //  NSLog("text = \(text)")
        }
        willSet {
            if (self.placeholder != nil) && (self.text != "")
            {
                let string = NSString(string : self.placeholder!)
                self.placeholderText(string)
            }

        }
    }
    @objc func textFieldDidChange(){
        if self.enableMaterialPlaceHolder {
            if (self.text == nil) || (self.text?.count)! > 0 {
                self.lblPlaceHolder.alpha = 1
                self.attributedPlaceholder = nil
                self.lblPlaceHolder.textColor = self.placeHolderColor
                self.lblPlaceHolder.frame.origin.x = 0 ////\\
                let fontSize = self.font!.pointSize;
                self.lblPlaceHolder.font = UIFont.init(name: (self.font?.fontName)!, size: fontSize-3)
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {() -> Void in
                if (self.text == nil) || (self.text?.count)! <= 0 {
                    self.lblPlaceHolder.font = self.defaultFont
                    self.lblPlaceHolder.frame = CGRect(x: self.lblPlaceHolder.frame.origin.x+10, y : 0, width :self.frame.size.width, height : self.frame.size.height)
                }
                else {
                    if self.directionMaterial == placeholderDirection.placeholderUp {
                        self.lblPlaceHolder.frame = CGRect(x : self.lblPlaceHolder.frame.origin.x, y : -self.difference, width : self.frame.size.width, height : self.frame.size.height)
                    }else{
                        self.lblPlaceHolder.frame = CGRect(x : self.lblPlaceHolder.frame.origin.x, y : self.difference, width : self.frame.size.width, height : self.frame.size.height)
                    }

                }
            }, completion: {(finished: Bool) -> Void in
            })
        }
    }
    func EnableMaterialPlaceHolder(enableMaterialPlaceHolder: Bool){
        self.enableMaterialPlaceHolder = enableMaterialPlaceHolder
        self.lblPlaceHolder = UILabel()
        self.lblPlaceHolder.frame = CGRect(x: 0, y : 0, width : 0, height :self.frame.size.height)
        self.lblPlaceHolder.font = UIFont.systemFont(ofSize: 10)
        self.lblPlaceHolder.alpha = 0
        self.lblPlaceHolder.clipsToBounds = true
        self.addSubview(self.lblPlaceHolder)
        self.lblPlaceHolder.attributedText = self.attributedPlaceholder
        //self.lblPlaceHolder.sizeToFit()
    }
    func placeholderText(_ placeholder: NSString){
        let atts  = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.labelFontSize] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: placeholder as String , attributes:atts)
        self.EnableMaterialPlaceHolder(enableMaterialPlaceHolder: self.enableMaterialPlaceHolder)
    }
    override public func becomeFirstResponder()->(Bool){
        let returnValue = super.becomeFirstResponder()
        return returnValue
    }
    override public func resignFirstResponder()->(Bool){
        let returnValue = super.resignFirstResponder()
        return returnValue
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
    }
}
