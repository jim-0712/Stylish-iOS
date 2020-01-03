//
//  DataNow.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/3.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import Foundation

struct HistoryList: Codable{
  let userid: String
  let list: [Lists]
  
  enum CodingKeys: String, CodingKey {
    case userid = "user_id"
    case list = "list"
  }
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



