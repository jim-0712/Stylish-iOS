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
  

  var total = 0
  
  func signInToSTYLiSH(fbToken: String, completion: @escaping (Result<Void>) -> Void) {
    
    HTTPClient.shared.request(STUserRequest.signin(fbToken), completion: { result in
      
      switch result {
        
      case .success(let data):
        
        do {
          
          let userObject = try JSONDecoder().decode(STSuccessParser<UserObject>.self, from: data)
          
          KeyChainManager.shared.token = userObject.data.accessToken
          StoreJimS.sharedJim.email = userObject.data.user.email
          UserDefaults.standard.set(userObject.data.user.email, forKey: "email")
          UserDefaults.standard.set(userObject.data.user.id, forKey: "id")
          UserDefaults.standard.set(userObject.data.user.name, forKey: "name")
          StoreJimS.sharedJim.id = userObject.data.user.id
          self.getData()
          self.lotteryData()
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
    

    LoginManager().logIn(permissions: ["email"], from: from, handler: { (result, error) in
      
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
        
        guard let token = result.token?.tokenString else {
          
          let fbError = FacebookError.noToken
          
          LKProgressHUD.showFailure(text: fbError.rawValue)
          
          return completion(Result.failure(fbError))
        }
        
        completion(Result.success(token))
      }
      
    })
  }
  
  func checkout(order: Order, prime: String, completion: @escaping (Result<Reciept>) -> Void) {
    
    guard let token = KeyChainManager.shared.token else {
      
      return completion(Result.failure(STYLiSHSignInError.noToken))
    }
    
    let body = CheckoutAPIBody(order: order, prime: prime)
    
    let request = STUserRequest.checkout(
      token: token,
      body: try? JSONEncoder().encode(body)
    )
    
    HTTPClient.shared.request(request, completion: { result in
      
      switch result {
        
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
  
  
  func getLottery(completion: @escaping (Result<Void>) -> Void){
    var storeManJim = StoreJimS.sharedJim
    let provider = UserProvider()
    let manager = ProfileManager()
    
    HTTPClient.shared.request(STUserRequest.lottery()) { result in
      
      switch result {
        
      case .success(let data):
        do {
          let lottery = try JSONDecoder().decode(STSuccessParser<Lottery>.self, from: data)
        } catch  {
          completion(Result.failure(error))
        }
        
      case .failure(let error):
        completion(Result.failure(error))
      }
    }
  }
  
  func lotteryData() {
    var storeManJim = StoreJimS.sharedJim
    let provider = UserProvider()
    let manager = ProfileManager()
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    let email = UserDefaults.standard.value(forKey: "email") as? String
    let newlottery = URL(string: "https://yssites.com/api/1.0/points")!
    var request = URLRequest(url: newlottery)
    request.httpMethod = "GET"
    request.addValue(email!, forHTTPHeaderField: "email")
    
    let task = session.dataTask(with: request) {(data, response, error)  in
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200 else {return}
      
      guard let data = data else {
        return
      }
      let decoder = JSONDecoder()
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let result  = try decoder.decode(Lottery.self, from: data)
        storeManJim.lottery = [result]
        print(result)
      } catch {
      }
    }
    task.resume()
  }
  
  
  func getData() {
    var storeManJim = StoreJimS.sharedJim
    let provider = UserProvider()
    let manager = ProfileManager()
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    let email = UserDefaults.standard.value(forKey: "email") as? String
    let shoppingCart = URL(string: "https://williamyhhuang.com/api/1.0/search")!
    var request = URLRequest(url: shoppingCart)
    request.httpMethod = "GET"
    request.addValue(email!, forHTTPHeaderField: "email")
    let task = session.dataTask(with: request) {(data, response, error)  in
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200 else {return}
      
      guard let data = data else {
        return
      }
      let decoder = JSONDecoder()
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let result  = try decoder.decode(HistoryList.self, from: data)
        storeManJim.historyData = [result]
        for count in 0 ..< result.total.count {
          self.total += result.total[count]
        }
        storeManJim.totalMoney = self.total
        self.lotteryData()
      } catch {
      }
    }
    task.resume()
  }
}
