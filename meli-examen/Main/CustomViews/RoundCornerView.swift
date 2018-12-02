//
//  RoundCornerView.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import UIKit

@IBDesignable
class RoundCornerView: UIView {
    
    fileprivate var shadowLayer = CAShapeLayer()
    fileprivate var defaultCornerRadius: CGFloat = 25.0
    
    override func awakeFromNib() {
        setUpMainView(fillColor: .white)
    }
    
    @IBInspectable
    var fillColor: UIColor? {
        didSet {
            setUpMainView(fillColor: fillColor)
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 25.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            self.defaultCornerRadius = cornerRadius
        }
    }
    
    private func setUpMainView(fillColor: UIColor?) {
        
        backgroundColor = UIColor.clear
        shadowLayer = CAShapeLayer()
        shadowLayer.fillColor = fillColor?.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 3
        
        shadowLayer.frame = bounds
        layer.insertSublayer(shadowLayer, at: 0)
        self.setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowLayer.frame = bounds
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: defaultCornerRadius).cgPath
    }
}
