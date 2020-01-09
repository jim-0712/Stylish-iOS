//
//  SignInViewController.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/8.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
  
  let jimManager = JimManager()
  
  var time1970 = NSTimeIntervalSince1970
  
  let now = NSDate()
  
  var currentTime = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UserDefaults.standard.set(false, forKey: "sign")
    
    let currentTimeS = now.timeIntervalSince1970
    currentTime = Int(currentTimeS) * 1000
    guard let isSign = UserDefaults.standard.value(forKey: "sign") as? Bool else { return }
    
    if  isSign {
      DispatchQueue.main.async {
        self.niceSignClick.isHidden = false
      }
    }else{
      DispatchQueue.main.async {
        self.niceSignClick.isHidden = true
      }
    }
    print(currentTime)
    getSignDataBack()
    
  }
  @IBOutlet weak var signImageView: UIImageView!
  @IBAction func signAction(_ sender: Any) {
    
    getSignSuccess()
    
    UserDefaults.standard.set(false, forKey: "sign")
    
    niceSignClick.isHidden = false
    
  }
  @IBOutlet weak var signBtnR: UIButton!
  
  @IBOutlet weak var niceSignClick: UIImageView!
  
  func getSignDataBack(){
    
    jimManager.signGet { result  in
      
      switch result {
        
      case .success(let data):
        
        print(data)
        
        
        
        var lastTime = StoreJimS.sharedJim.signBack[0].time
        
        guard let finalTime = Int(lastTime) else { return }
        
        if self.currentTime - finalTime > 5 {
          DispatchQueue.main.async {
            StoreJimS.sharedJim.totalPoints = data.totalpoints
            StoreJimS.sharedJim.clickOrNot = false
            UserDefaults.standard.set(false, forKey: "sign")
          }
        }else {
          DispatchQueue.main.async {
          
            StoreJimS.sharedJim.clickOrNot = true
            UserDefaults.standard.set(true, forKey: "sign")
          }
        }
        
      case .failure(let error):
        
        print(error)
        
      }
    }
  }
  
  
  func getSignSuccess(){
    
    let time = Int(self.time1970 * 1000)
    
    jimManager.postEveryDaySign(time: time ) { result  in
      
      switch result {
        
      case .success(let data):
        DispatchQueue.main.async {
          UserDefaults.standard.set(true, forKey: "sign")
         
          self.niceSignClick.alpha = 1.0
          self.success()
        }
        StoreJimS.sharedJim.clickOrNot = true
        print(data)
        
      case .failure(let error):
        
        print(error)
        
      }
    }
  }
  
  
  func success() {
    
    let alert = UIAlertController(title: "簽到成功", message: "Success", preferredStyle: UIAlertController.Style.alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
}
