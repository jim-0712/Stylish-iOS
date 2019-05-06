//
//  STParser.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

struct STSuccessParser<T: Codable>: Codable {

    let data: T

    let paging: Int?
}

struct STFailureParser: Codable {

    let errorMessage: String
}
