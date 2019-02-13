//
//  STRequest.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

enum STHTTPMethod: String {
    
    case GET
    
    case POST
}

enum STMarketRequest: STRequest {
    
    case hots
    
    var headers: [String: String] {
        
        switch self {
            
        case .hots: return [:]
        
        }
    }
    
    var body: Data? {
        
        switch self {
            
        case .hots: return nil
            
        }
    }
    
    var method: String {
        
        switch self {
            
        case .hots: return STHTTPMethod.GET.rawValue
            
        }
    }
    
    var endPoint: String {
        
        switch self {
            
        case .hots: return "marketing/hots"
            
        }
    }

}
