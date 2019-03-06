//
//  KeyChainManager.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import KeychainAccess

class KeyChainManager {
    
    static let shared = KeyChainManager()
    
    private let service: Keychain
    
    private let serverTokenKey: String = "STYLiSHToken"
    
    private init() {
        
        service = Keychain(service: Bundle.main.bundleIdentifier!)
    }
    
    var token: String? {
        
        set {
            service[serverTokenKey] = newValue
        }
        
        get {
            
            for item in service.allItems() {
                
                if let key = item["key"] as? String,
                   key == serverTokenKey {
                
                    return item["value"] as? String
                }
            }
            
            return nil
        }
    }
}
