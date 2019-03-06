//
//  UserObject.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

struct UserObject: Codable {
    
    let access_token: String
    
    let user: User
}

struct User: Codable {
    
    let id: Int
    
    let provider: String
    
    let name: String
    
    let email: String
    
    let picture: String
}

struct Reciept: Codable {
    
    let number: String
}
