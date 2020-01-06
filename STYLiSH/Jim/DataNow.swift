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
