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
        
        whyText.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sendWhy.isEnabled = false
    }
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var sendWhy: UIButton!
    @IBOutlet weak var whyText: UITextView!
    
    @IBAction func sendWhy(_ sender: Any) {
        
        whyRefund()
//        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
         NotificationCenter.default.post(name: Notification.Name("reloadTicket"), object: nil)
//        reloadTicket
        sendWhy.isEnabled = false
    }
    
    func getRefundData() {
        
        guard let email = UserDefaults.standard.value(forKey: "email") else { return }
        
        jimManager.canRefundData (completion: { result in
            
            switch result {
                
            case .success(let recommands):
                
                print(recommands)
                
                DispatchQueue.main.async {
                    self.success()
                }
                
            case .failure(let error):
                
                print(error)
            }
            
        })
    }
    
    func success() {
        
        let alert = UIAlertController(title: "申請退貨成功！", message: "客服人員將儘速替您處理。", preferredStyle: UIAlertController.Style.alert)
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

extension WhyViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if whyText.text != nil {
            sendWhy.isEnabled = true
            sendWhy.backgroundColor = .black
        } else {
            return
        }
    }
}
