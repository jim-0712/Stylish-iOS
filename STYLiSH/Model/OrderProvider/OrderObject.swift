//
//  OrderObject.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

struct Order {

    var products: [LSOrder] = []

    var reciever: Reciever = Reciever()

    var deliverTime: String = "08:00-12:00"

    var payment: Payment = .cash

    var productPrices: Int {

        var price = 0

        for item in products {

            price += Int(item.product!.price) * Int(item.amount)
        }

        return price
    }

    var freight: Int {

        return products.count * 60
    }

    var totalPrice: Int {

        return productPrices + freight
    }

    var amount: Int {

        var result = 0

        for item in products {

            result += Int(item.amount)
        }

        return result
    }

    func isReady() -> Bool {

        guard reciever.isReady() == true,
              deliverTime != nil,
              deliverTime != ""
        else {
            return false
        }

        return true
    }
    
    init(products: [LSOrder]) {
        
        self.products = products
    }
}

struct Reciever {

    var name: String = String.empty

    var email: String = String.empty

    var phoneNumber: String = String.empty

    var address: String = String.empty
    
    var shipTime: String = String.empty

    func isReady() -> Bool {

        guard name != String.empty,
              email != String.empty,
              phoneNumber != String.empty,
              address != String.empty
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
