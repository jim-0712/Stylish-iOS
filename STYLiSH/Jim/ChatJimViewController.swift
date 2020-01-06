//
//  ChatJimViewController.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/5.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ChatJimViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    IQKeyboardManager.shared.enable = true
    // Do any additional setup after loading the view.
  }
  
  @IBOutlet weak var answerTextView: UITextView!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var reallyQuestionText: UITextField!
  @IBOutlet weak var sendButton: UIButton!
  
  @IBAction func sendAction(_ sender: Any) {
  }
  
  var questionType = ""
  @IBAction func questionSegAction(_ sender: UISegmentedControl) {
    
    switch sender.selectedSegmentIndex {
    case 0 :
      questionType = "0"
      self.answerTextView.text = ""
    case 1 :
      questionType = "1"
      self.answerTextView.text = ""
    case 2 :
      questionType = "2"
        self.answerTextView.text = "STYLish以會員制度進行線上交易，為您提供簡單快速且專業的購物流程，首次購物請先加入會員再進行購物。購物流程：將您喜歡的商品加入購物車→ 登入會員資料→選擇付款方式→LOVFEE出貨通知→收到商品。"
    default:
      questionType = "3"
        self.answerTextView.text = "7-11超商取貨付款（包裹材積限制：長45cm*寬30cm*高30cm）、中華郵政（若付款付款金額為零，故務必於訂單內填寫與身分證上相符的姓名，領取包裹時提供身分證以利核對）。"
        
    }
  }
  
}
  
