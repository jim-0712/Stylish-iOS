//
//  WhyViewController.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/6.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class WhyViewController: UIViewController {

  
  var storeManJim = StoreJimS.sharedJim
  let jimManager = JimManager()
  var number = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  @IBOutlet weak var numberLabel: UILabel!
 
  @IBOutlet weak var whyTextField: UITextField!
  
   @IBAction func sendWhy(_ sender: Any) {
   }
  
  

  func getRefund(){
    
    let numberString = String(number)
    
    jimManager.postWhyRefund(number: numberString, why: whyTextField.text!, options: "退貨") { result in
            switch result {
    
            case .success(let recommands):
    
              print(recommands)
    
            case .failure(let error):
    
              print(error)
            }
          }
  
  }
}
