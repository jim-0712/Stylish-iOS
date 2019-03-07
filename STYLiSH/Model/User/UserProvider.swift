//
//  UserManager.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import FBSDKLoginKit

typealias FacebookResponse = (Result<String>) -> Void

enum FacebookError: String, Error {
    
    case noToken = "讀取 Facebook 資料發生錯誤！"
    
    case userCancel

    case denineEmailPermission = "請允許存取 Facebook email！"
}

enum STYLiSHSignInError: Error {
    
    case noToken
}

class UserProvider {
    
    func signInToSTYLiSH(fbToken: String, completion: @escaping (Result<Void>) -> Void) {
        
        HTTPClient.shared.request(STUserRequest.signin(fbToken), completion: { result in
            
            switch result{
                
            case .success(let data):
                
                do {
                    
                    let userObject = try JSONDecoder().decode(STSuccessParser<UserObject>.self, from: data)
                    
                    KeyChainManager.shared.token = userObject.data.access_token

                    completion(Result.success(()))
                    
                } catch {
                    
                    completion(Result.failure(error))
                }
                
            case .failure(let error):
                
                completion(Result.failure(error))
            }
            
        })
    }
    
    func loginWithFaceBook(from: UIViewController, completion: @escaping FacebookResponse) {
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: from, handler: { (result, error) in
            
            guard error == nil else { return completion(Result.failure(error!)) }
        
            guard let result = result else {
                
                let fbError = FacebookError.noToken
                
                LKProgressHUD.showFailure(text: fbError.rawValue)
                
                return completion(Result.failure(fbError))
            }
            
            switch result.isCancelled {
                
            case true: break
                
            case false:
                
                guard result.declinedPermissions.contains("email") == false else {
                    
                    let fbError = FacebookError.denineEmailPermission
                    
                    LKProgressHUD.showFailure(text: fbError.rawValue)
                    
                    return completion(Result.failure(fbError))
                }
                
                guard let token = result.token.tokenString else {
                    
                    let fbError = FacebookError.noToken
                    
                    LKProgressHUD.showFailure(text: fbError.rawValue)
                    
                    return completion(Result.failure(fbError))
                }

                completion(Result.success(token))
            }
            
        })
    }
    
    func checkout(prime: String, completion: @escaping (Result<Reciept>) -> Void) {
        
        guard let token = KeyChainManager.shared.token else {
            
            return completion(Result.failure(STYLiSHSignInError.noToken))
        }
        
        let request = STUserRequest.checkout(
            token: token,
            body:
            [
                "prime": prime,
                "order": [
                    "shipping": "delivery",
                    "payment": "credit_card",
                    "subtotal": 1234,
                    "freight": 14,
                    "total": 1300,
                    "recipient": [
                        "name": "Luke",
                        "phone": "0987654321",
                        "email": "luke@gmail.com",
                        "address": "市政府站",
                        "time": "morning"
                    ],
                    "list": [
                        [
                            "id": "201807202157",
                            "name": "活力花紋長筒牛仔褲",
                            "price": 1299,
                            "color": [
                                "code": "DDF0FF",
                                "name": "淺藍"
                            ],
                            "size": "M",
                            "qty": 1
                        ]
                    ]
                ]
            ]
        )
        
        HTTPClient.shared.request(request, completion: { result in
            
            switch result{
                
            case .success(let data):
                
                do {
                    
                    let reciept = try JSONDecoder().decode(STSuccessParser<Reciept>.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        completion(Result.success(reciept.data))
                    }
                    
                } catch {
                    
                    completion(Result.failure(error))
                }
                
            case .failure(let error):
                
                completion(Result.failure(error))
            }
        })
    }
    
}