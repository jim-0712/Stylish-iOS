//
//  DataNow.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/3.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import Foundation

struct HistoryList: Codable{
  let user: String
  let list: [Lists]
}

struct Lists: Codable {
  let orderid: String
  let product: [HistoryProduct]
  
  enum CodingKeys: String, CodingKey {
    case orderid = "order_id"
    case product = "product"
  }
}

struct HistoryProduct: Codable {
  let id: String
  let name: String
  let size: String
  let color: ColorsY
  let price: String
  let qty: String
  let picture: String
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

