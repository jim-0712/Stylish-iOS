//
//  OrderObject.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

struct Order {
    
    var orders: [LSOrder] = []
    
    var reciever: Reciever?
    
    var deliverTime: String?
    
    var payment: Payment?
    
    var productPrices: Int {
        
        var price = 0
        
        for item in orders {
            
            price += Int(item.product!.price) * Int(item.amount)
        }
        
        return price
    }
    
    var freight: Int {
        
        return orders.count * 60
    }
    
    var totalPrice: Int {
        
        return productPrices + freight
    }
    
    var amount: Int {
        
        var result = 0
        
        for item in orders {
            
            result += Int(item.amount)
        }
        
        return result
    }
    
    func isReady() -> Bool {
        
        guard reciever?.isReady() == true,
              deliverTime != nil,
              payment != nil,
              deliverTime != ""
        else {
            return false
        }
        
        return true
    }
}

struct Reciever {
    
    var name: String?
    
    var email: String?
    
    var phoneNumber: String?
    
    var address: String?
    
    func isReady() -> Bool {
        
        guard name != nil,
              email != nil,
              phoneNumber != nil,
              address != nil,
              name != "",
              email != "",
              phoneNumber != "",
              address != ""
        else {
              return false
        }
        
        return true
    }
}

enum Payment: String {
    
    case cash = "貨到付款"
    
    case credit = "信用卡付款"
}
