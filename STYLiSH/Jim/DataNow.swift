//
//  DataNow.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/3.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import Foundation

struct HistoryList: Codable {
  let total: [Int]
  let orderlist: [Lists]
  
  enum CodingKeys: String, CodingKey {
    case orderlist = "order_list"
    case total
  }
}

struct Lists: Codable {
  let number: String
  let list: [HistoryProduct]
}

struct HistoryProduct: Codable {
  let id: String
  let qty: Int
  let name: String
  let size: String
  let color: String
  let price: Int
  let mainimage: String
  
  enum CodingKeys: String, CodingKey {
    case mainimage = "main_image"
    case id, qty, name, size, color, price
  }
}


struct Lottery: Codable{
  let email: String
  let totalpoints: Int
  let coupon: Coupons
  
  enum CodingKeys: String, CodingKey {
    case totalpoints = "total_points"
    case email = "email"
    case coupon = "coupon"
  }
}

struct Coupons: Codable {
  let tenpercent: [Int]
  let shipfree: [Int]
  
  enum CodingKeys: String, CodingKey {
    case tenpercent = "ten_percent"
    case shipfree = "ship_free"
  }
}


struct WantRefund: Codable {
  let number: String
  let details: RefundOrder
}

struct RefundOrder: Codable {
  let shipping: String
  let payment: String
  let subtotal: Int
  let freight: Int
  let total: Int
  let recipient: BuyName
  let list: [Buylist]
}

struct BuyName: Codable {
  let name: String
  let phone: String
  let email: String
  let address: String
  let time: String
}

struct Buylist: Codable {
  let id: String
  let name: String
  let price: Int
  let color: String
  let size: String
  let qty: Int
  
}



struct ResponseWhy: Codable {
  let productbacknumber: String
  let ordernumber: String
  let status: Int
  
  enum CodingKeys: String, CodingKey {
    case productbacknumber = "product_back_number"
    case ordernumber = "order_number"
    case status
  }
  
}

struct BackComment: Codable {
  
  let userid: Int
  let ordernumber : String
  let productid: String
  let time: String
  let star: String
  let comment: String
 // let pic: String
  let status: Int
  
  enum CodingKeys: String, CodingKey {
    case userid = "user_id"
    case ordernumber = "order_number"
    case productid = "product_id"
    case time, star, comment, status
  }
  
}

struct SignIn: Codable {
  let time: String
  let totalpoints: Int
  
  enum CodingKeys: String, CodingKey {
     case totalpoints = "total_points"
     case time
   }
}

struct SignFeedBack: Codable {
  let message: String
}
