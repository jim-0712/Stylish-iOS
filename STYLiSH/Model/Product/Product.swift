//
//  Product.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

struct PromotedProducts: Codable {
    
    let title: String
    
    let products: [Product]
}

struct Product: Codable {
    
    let id: Int
    
    let title: String
    
    let description: String
    
    let price: Int
    
    let texture: String
    
    let wash: String
    
    let place: String
    
    let note: String
    
    let story: String
    
    let colors: [Color]
    
    let sizes: [String]
    
    let variants: [Variant]
    
    let main_image: String
    
    let images: [String]
}

struct Color: Codable {
    
    let name: String

    let code: String
}

struct Variant: Codable {
    
    let color_code: String
    
    let size: String
    
    let stock: Int
}


