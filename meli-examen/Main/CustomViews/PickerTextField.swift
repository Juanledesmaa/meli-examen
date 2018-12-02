//
//  PickerTextField.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import UIKit

enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

@IBDesignable
class PickerTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addLineToView(view: self, position:.LINE_POSITION_BOTTOM, color: Colors.mainBlue, width: 0.5)
    }
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var paddingBottom: Float = 45.0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rtl: Bool = false { didSet { updateView() }}
    
    @IBInspectable var isSmallIcon: Bool = false { didSet { updateView() }}
    
    func updateView() {
        
        rightViewMode = UITextField.ViewMode.never
        rightView = nil
        leftViewMode = UITextField.ViewMode.never
        leftView = nil
        
        if let image = leftImage {
            var imageView = UIImageView()
            
            if isSmallIcon {
                imageView = UIImageView(frame: CGRect(x: 20, y: 10, width: 10, height: 10))
            } else {
                imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            }
            
            imageView.image = image
            imageView.tintColor = color
            imageView.contentMode = .scaleAspectFit
            let viewLeft: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 20))
            viewLeft.addSubview(imageView)
            
            if rtl {
                rightViewMode = UITextField.ViewMode.always
                rightView = viewLeft
            } else {
                leftViewMode = UITextField.ViewMode.always
                leftView = viewLeft
            }
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    func addLineToView(view : UIView, position : LINE_POSITION, color: UIColor, width: Double) {
        
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .LINE_POSITION_TOP:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            view.addConstraint(NSLayoutConstraint.init(item: lineView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: CGFloat(paddingBottom)))
            break
        }
    }
}
