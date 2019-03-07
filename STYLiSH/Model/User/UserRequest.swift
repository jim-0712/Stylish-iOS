//
//  UserRequest.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

enum STUserRequest: STRequest {
    
    case signin(String)
    
    case checkout(token: String, body: [String: Any])
    
    var headers: [String: String] {
        
        switch self {
            
        case .signin(_):
            
            return [STHTTPHeaderField.contentType.rawValue: STHTTPHeaderValue.json.rawValue]
        
        case .checkout(let token, _):
            
            return [
                STHTTPHeaderField.auth.rawValue: "Bearer \(token)",
                STHTTPHeaderField.contentType.rawValue: STHTTPHeaderValue.json.rawValue
            ]
        }
    }
    
    var body: [String: Any]? {
        
        switch self {
            
        case .signin(let token):
            
            return [
                "provider": "facebook",
                "access_token": token
            ]
            
        case .checkout(_, let body):
            
            return body
        }
    }
    
    var method: String {
        
        switch self {
            
        case .signin, .checkout: return STHTTPMethod.POST.rawValue
        
        }
    }
    
    var endPoint: String {
        
        switch self {
            
        case .signin: return "/user/signin"
        
        case .checkout: return "/order/checkout"
        }
    }
    
}
