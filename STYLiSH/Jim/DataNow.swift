//
//  DataNow.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/3.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import Foundation

struct HistoryList: Codable{
  let total: [Int]
  let orderlist: [Lists]
  
  enum CodingKeys: String, CodingKey {
    case orderlist = "order_list"
    case total
  }
}

struct Lists: Codable {
  let number: String
  let list: HistoryProduct
}

struct HistoryProduct: Codable {
  let id: Int
  let qty: Int
  let name: String
  let size: String
  let color: ColorsY
  let price: Int
  let mainimage: String
  
  enum CodingKeys: String, CodingKey {
    case mainimage = "main_image"
    case id, qty, name, size, color, price
  }
 }

struct ColorsY: Codable {
  let colorcode: String
  let colorname: String
  
  enum CodingKeys: String, CodingKey {
    case colorcode = "color_code"
    case colorname = "color_name"
  }
}

struct FromSty: Codable {
  let data: FromData
}

struct FromData: Codable {
  let id: Int
  let provider: String
  let name: String
  let email: String
  let picture: String
}
