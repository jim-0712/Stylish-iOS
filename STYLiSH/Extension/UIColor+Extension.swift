//
//  UIColor+Extension.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

private enum STColor: String {
    
    case B1
    
    case B2
}

extension UIColor {
    
    static let B1 = STColor(.B1)
    
    private static func STColor(_ color: STColor) -> UIColor? {
        
        return UIColor(named: color.rawValue)
    }
}
