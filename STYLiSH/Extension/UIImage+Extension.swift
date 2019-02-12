//
//  UIImage+Extension.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/11.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

enum ImageAsset: String {
    
    case Icons_36px_Home_Normal
    
    case Icons_36px_Home_Selected
    
    case Icons_36px_Profile_Normal
    
    case Icons_36px_Profile_Selected

    case Icons_36px_Cart_Normal
    
    case Icons_36px_Cart_Selected
    
    case Icons_36px_Catalog_Normal
    
    case Icons_36px_Catalog_Selected
}

extension UIImage {
    
    static func asset(_ asset: ImageAsset) -> UIImage? {
        
        return UIImage(named: asset.rawValue)
    }
}
