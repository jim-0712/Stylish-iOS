//
//  OrderProvider.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

class OrderProvider {

    enum OrderInfo: String {
    
        case products = "結帳商品"
        
        case reciever = "收件資訊"
        
        case paymentInfo = "付款詳情"
    }
    
    let orderCustructor: [OrderInfo] = [.products, .reciever, .paymentInfo]
    
    let payments: [Payment] = [.cash, .credit]
    
    var order: Order
    
    init(order: Order) {
        
        self.order = order
    }
}
