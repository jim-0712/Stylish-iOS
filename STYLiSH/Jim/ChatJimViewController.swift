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
    switch sender.selectedSegmentIndex{
    case 0 :
      questionType = "0"
    case 1 :
      questionType = "1"
    case 2 :
      questionType = "2"
    default:
      questionType = "3"
    }
  }
  
  
  
}
  
