//
//  UIView+Extension.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/28.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView {
    
    //Border Color
    @IBInspectable var lkBorderColor: UIColor? {
        get {
            
            guard let borderColor = layer.borderColor else {
                
                return nil
            }
            
            return UIColor(cgColor: borderColor)
        }
        set {
            layer.borderColor = lkBorderColor?.cgColor
        }
    }
    
    //Border width
    @IBInspectable var lkBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = lkBorderWidth
        }
    }
    
    //Corner radius
    @IBInspectable var lkCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = lkCornerRadius
        }
    }
    
    func stickSubView(_ objectView: UIView) {
        
        addSubview(objectView)
        
        objectView.translatesAutoresizingMaskIntoConstraints = false
        
        objectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        objectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        objectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        objectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
