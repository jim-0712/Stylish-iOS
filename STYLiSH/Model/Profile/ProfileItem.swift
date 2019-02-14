//
//  ProfileItem.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/14.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

protocol ProfileItem {
    
    var image: UIImage? { get }
    
    var title: String { get }
}

enum ProfileSegue: String {
    
    case SegueAllOrder = "AllOrder"
    
    var title: String {
        
        switch self {
        
        case .SegueAllOrder: return "查看全部"
        
        }
    }
}

struct ProfileGroup {
    
    let title: String
    
    let action: ProfileSegue?
    
    let items: [ProfileItem]
}

enum OrderItem: ProfileItem {
    
    case awaitingPayment
    
    case awaitingShipment
    
    case shipped
    
    case awaitingReview
    
    case exchange
    
    var image: UIImage? {
        
        switch self {
        
        case .awaitingPayment: return UIImage.asset(.Icons_24px_AwaitingPayment)
            
        case .awaitingShipment: return UIImage.asset(.Icons_24px_AwaitingShipment)
            
        case .shipped: return UIImage.asset(.Icons_24px_Shipped)
            
        case .awaitingReview: return UIImage.asset(.Icons_24px_AwaitingReview)
        
        case .exchange: return UIImage.asset(.Icons_24px_Exchange)
            
        }
    }
    
    var title: String {
        
        switch self {
            
        case .awaitingPayment: return "待付款"
            
        case .awaitingShipment: return "待出貨"
            
        case .shipped: return "待簽收"
            
        case .awaitingReview: return "待評價"
            
        case .exchange: return "退換貨"
            
        }
    }
}

enum ServiceItem: ProfileItem {
    
    case collcetion
    
    case notification
    
    case refund
    
    case address
    
    case customService
    
    case systomReport
    
    case bindPhone
    
    case setting
    
    var image: UIImage? {
        
        switch self {
            
        case .collcetion: return UIImage.asset(.Icons_24px_Starred)
        
        case .notification: return UIImage.asset(.Icons_24px_Notification)
        
        case .refund: return UIImage.asset(.Icons_24px_Refunded)
            
        case .address: return UIImage.asset(.Icons_24px_Address)
            
        case .customService: return UIImage.asset(.Icons_24px_CustomerService)

        case .systomReport: return UIImage.asset(.Icons_24px_SystemFeedback)
            
        case .bindPhone: return UIImage.asset(.Icons_24px_RegisterCellphone)
            
        case .setting: return UIImage.asset(.Icons_24px_Settings)
        }
    }
    
    var title: String {
        
        switch self {
            
        case .collcetion: return "收藏"
            
        case .notification: return "貨到通知"
            
        case .refund: return "帳戶退款"
            
        case .address: return "地址"
            
        case .customService: return "客服訊息"
            
        case .systomReport: return "系統回饋"
            
        case .bindPhone: return "手機綁定"
            
        case .setting: return "設定"
        }
    }
}
