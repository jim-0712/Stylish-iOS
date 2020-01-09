//
//  WhyViewController.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/6.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class WhyViewController: UIViewController {

  var storeManJim = StoreJimS.sharedJim
  let jimManager = JimManager()
  var number = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
      numberLabel.text = "訂單編號：\(number)"
       IQKeyboardManager.shared.enable = true
        // Do any additional setup after loading the view.
    }
    
  @IBOutlet weak var numberLabel: UILabel!
 
  @IBOutlet weak var whyText: UITextView!
  
   @IBAction func sendWhy(_ sender: Any) {
    
    whyRefund()
    
   }
  
  func getRefundData() {
    guard let email = UserDefaults.standard.value(forKey: "email") else { return }
    jimManager.canRefundData (completion: { result in
        
        switch result {
            
        case .success(let recommands):
      
            print(recommands)
            
            let message = StoreJimS.sharedJim.refundNum[0].productbacknumber
          
            self.success(message: message)
            
        case .failure(let error):
        
            print(error)
        }
        
    })
  }
  
  func success(message: String) {
    
    let alert = UIAlertController(title: "退貨編號", message: message, preferredStyle: UIAlertController.Style.alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  func whyRefund() {
    
    let numberString = String(number)
    let current = "0\(numberString)"
    
    jimManager.postWhyRefund(number: current, why: whyText.text!, options: "退貨") { result in
            switch result {
    
            case .success(let recommands):
    
              print(recommands)
              
              self.getRefundData()
              
              NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
    
            case .failure(let error):
    
              print(error)
            }
          }
  
  }
}
