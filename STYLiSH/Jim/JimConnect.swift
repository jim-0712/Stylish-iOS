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
  
  case productCommentBack(productId: String)
  
  case everyDaySignPost(email: String, time: Int, totalPoints: Int)
  
  case signGet(email: String)
  
  var headers: [String: String] {
    
    switch self {
      
    case .whyRefundMessage(let email,_,_,_):
      
      return ["Content-Type" :"application/json" ,STHTTPHeaderField.email.rawValue: "\(email)"]
      
    case .switchProduct(let email):
      
      return [STHTTPHeaderField.email.rawValue: "\(email)"]
      
    case .productCommentBack(let productId):
      
      return ["productid": productId, "status": "1"]
      
    case .everyDaySignPost(let email, let time, let totalPoints):
      
      return [
        "email": email,
        "Content-Type" :"application/json"
      ]
      
    case .signGet(let email):
      
      return ["email": email]
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
      
      let reallyData = try? JSONSerialization.data(withJSONObject: package, options: .prettyPrinted)
      
      return reallyData
      
    case .everyDaySignPost(let email, let time, let totalPoints):
      
      let dict: [String: Any] = [
        "time": time,
        "total_points": totalPoints
      ]
      
      struct Test: Codable {
        let time: String
        let total: String
        
        enum CodingKeys: String, CodingKey {
          case time
          case total = "total_points"
        }
      }
 
      let reallyData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
      
     
      return reallyData
      
    case .switchProduct, .productCommentBack, .signGet:
      
      return nil
      
    }
  }
  var method: String {
    
    switch self {
      
    case .whyRefundMessage, .everyDaySignPost: return STHTTPMethod.POST.rawValue
      
    case .switchProduct, .productCommentBack, .signGet: return STHTTPMethod.GET.rawValue
      
    }
  }
  
  var endPoint: String {
    
    switch self {
      
    case .whyRefundMessage , .switchProduct: return "/returnProduct"
      
    case .productCommentBack: return "/comment"
      
    case .everyDaySignPost, .signGet: return "/sign"
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
  
  
  
  func productCommentReturn(completion : @escaping ((Result<[BackComment]>)) -> Void){
    
    let productId = StoreJimS.sharedJim.commentProductId
    
    HTTPClient.shared.request(JimRequest.productCommentBack(productId: productId)) { result in
      
//      guard let strongSelf = self else { return }
      
      switch result {
        
      case .success(let data):
        
        do {
          let apple = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
          
          let productBack = try self.decoder.decode([BackComment].self, from: data)
          
          StoreJimS.sharedJim.productBack = productBack
          
          completion(.success(productBack))
          
        } catch  {
          
          completion(.failure(error))
        }
        
      case .failure(let error):
        
        completion(.failure(error))
      }
    }
    
  }
  
  func postEveryDaySign(time: Int, completion: @escaping ((Result<SignFeedBack>) -> Void)){
    
    guard let email = UserDefaults.standard.value(forKey: "email") else { return }
    guard let stringEmail = email as?String else { return }
    var totalPoints = StoreJimS.sharedJim.totalPoints
    totalPoints += 1
    let data = JimRequest.everyDaySignPost(email: stringEmail, time: time, totalPoints: totalPoints).makeRequest().httpBody
    
    print(String(data: data!, encoding: .utf8))
    
    HTTPClient.shared.request(JimRequest.everyDaySignPost(email: stringEmail, time: time, totalPoints: totalPoints)) { result in
      
      switch result {
        
      case .success(let data):
        
        do {
          let apple = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
          
          let postSignBack = try self.decoder.decode(SignFeedBack.self, from: data)
          
          StoreJimS.sharedJim.signFeedBack = [postSignBack]
          
          completion(.success(postSignBack))
          
        } catch  {
          
          completion(.failure(error))
        }
        
      case .failure(let error):
        
        completion(.failure(error))
      }
      
    }
  }
  
  func signGet(completion: @escaping ((Result<SignIn>) -> Void)){
    
    guard let email = UserDefaults.standard.value(forKey: "email") else { return }
    guard let stringEmail = email as?String else { return }
    
    HTTPClient.shared.request(JimRequest.signGet(email: stringEmail)) { result in
      
      switch result {
        
      case .success(let data):
        
        do {
          let apple = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
          
          let signBack = try self.decoder.decode(SignIn.self, from: data)
          
          StoreJimS.sharedJim.signBack = [signBack]
          
          StoreJimS.sharedJim.totalPoints = signBack.totalpoints
          
          completion(.success(signBack))
          
        } catch  {
          
          completion(.failure(error))
        }
        
      case .failure(let error):
        
        completion(.failure(error))
      }
      
    }
  }
}
