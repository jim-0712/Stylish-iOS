//
//  File.swift
//  STYLiSH
//
//  Created by Savannah Su on 2020/1/6.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import Foundation

struct CustomerData: Codable {
    let data: CustomerQuest
}

struct CustomerQuest: Codable {
    let comment: String
}

struct ServiceData: Codable {
    let serviceNumber: String
    
    private enum CodingKeys: String, CodingKey {
        case serviceNumber = "service_number"
    }
}
