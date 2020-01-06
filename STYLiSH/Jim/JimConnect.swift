//
//  File.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/6.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import Foundation

enum JimRequest: STRequest {
  
  case whyRefundMessage(email: String,number: String, why: String, options: String)
  
  case switchProduct(email: String)
  
  var headers: [String: String] {
    
    switch self {
      
    case .whyRefundMessage(let email):
      
      return ["Content-Type" :"application/json" ,STHTTPHeaderField.email.rawValue: "\(email)"]
      
    case .switchProduct(let email):
      
      return [STHTTPHeaderField.email.rawValue: "\(email)"]
    }
  }
  
  var body: Data? {
    
    switch self {
      
    case .whyRefundMessage(let email,let number, let why, let options):
      
      let dict = [
        "number": number,
        "why": why,
        "options": options
      ]
      
      let package = ["data": dict]
      
      return try? JSONSerialization.data(withJSONObject: package, options: .prettyPrinted)
      
    case .switchProduct:
      
      return nil
    }
  }
  var method: String {
    
    switch self {
      
    case .whyRefundMessage: return STHTTPMethod.POST.rawValue
      
    case .switchProduct: return STHTTPMethod.GET.rawValue
      
    }
  }
  
  var endPoint: String {
    
    switch self {
      
    case .whyRefundMessage , .switchProduct: return "/returnProduct"
    }
  }
}


class  JimManager {
  let decoder = JSONDecoder()
  
  func postWhyRefund(number: String,why: String, options: String,completion : @escaping ((Result<ResponseWhy>) -> Void)){
    
    let email = UserDefaults.standard.value(forKey: "email") as? String
    
    HTTPClient.shared.request(JimRequest.whyRefundMessage(email: email!, number: number, why: why, options: options)) { [weak self] result in
      
      guard let strongSelf = self else { return }
      
      switch result {
        
      case .success(let data):
        
        do {
          
          let refundData = try strongSelf.decoder.decode(ResponseWhy.self, from: data)
          
          completion(.success(refundData))
          
        } catch  {
          
          completion(.failure(error))
        }
        
      case .failure(let error):
        
        completion(.failure(error))
      }
    }
    
  }
  
  
  func canRefundData(completion : @escaping ((Result<[WantRefund]>) -> Void)){
    
    let email = UserDefaults.standard.value(forKey: "email") as? String
    
    HTTPClient.shared.request(JimRequest.switchProduct(email: email!)) { [weak self] result in
      
      guard let strongSelf = self else { return }
      
      switch result {
        
      case .success(let data):
        
        do {
          let apple = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
          
          let refundData = try strongSelf.decoder.decode([WantRefund].self, from: data)
          
          StoreJimS.sharedJim.refundData = refundData
          
          completion(.success(refundData))
          
        } catch  {
          
          completion(.failure(error))
        }
        
      case .failure(let error):
        
        completion(.failure(error))
      }
    }
    
    
  }
}
