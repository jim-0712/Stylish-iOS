//
//  UIFont+Extension.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

private enum STFontName: String {
    
    case medium = "PingFangTC-Medium"
    
    case regular = "PingFangTC-Regular"
}

extension UIFont {
    
    static func medium(size: CGFloat) -> UIFont? {
        
        return STFont(.medium, size: size)
    }
    
    static func regular(size: CGFloat) -> UIFont? {
        
        return STFont(.regular, size: size)
    }
    
    private static func STFont(_ font: STFontName, size: CGFloat) -> UIFont? {
        
        return UIFont(name: font.rawValue, size: size)
    }
}


