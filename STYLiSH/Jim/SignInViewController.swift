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
    
    let currentTimeS = now.timeIntervalSince1970
    currentTime = Int(currentTimeS)
    
    print(currentTime)
    getSignDataBack()
    
  }
  @IBOutlet weak var signImageView: UIImageView!
  @IBAction func signAction(_ sender: Any) {
    
    getSignSuccess()
    
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
        
        var time = Int(self.time1970)
               
           time *=  1000
        
        if self.currentTime - finalTime > 200 {
          self.signBtnR.isEnabled = true
          DispatchQueue.main.async {
            self.niceSignClick.alpha = 0.0
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
            self.signBtnR.isEnabled = false
            self.niceSignClick.alpha = 1.0
        }
        print(data)
        
      case .failure(let error):
        
        print(error)
        
      }
    }
  }
  
  
  func success(message: String) {
    
    let alert = UIAlertController(title: "簽到成功", message: message, preferredStyle: UIAlertController.Style.alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
}
