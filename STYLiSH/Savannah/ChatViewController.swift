//
//  ChatViewController.swift
//  STYLiSH
//
//  Created by Savannah Su on 2020/1/3.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ChatViewController: UIViewController {

    var chatCount = 1
    var ownerQuestion: [String] = []
    var dbAnswer: [String] = []
    var questionIndex = 0
    
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var customerText: UITextField!
    @IBAction func sendButton(_ sender: Any) {
        
        guard let question = customerText.text else{ return }
        ownerQuestion.append(question)
        chatCount += 2
        chatTable.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTable.delegate = self
        chatTable.dataSource = self
        self.navigationItem.title = "Chat Room"
        chatTable.separatorStyle = .none
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = true
    }
}

extension ChatViewController: UITableViewDelegate {
  
}

extension ChatViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chatCount
  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row % 2 == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Server Cell", for: indexPath) as? ServerTableViewCell else {
                return UITableViewCell()
            }
            
            cell.messageLabel.text = "您好，請問有什麼可以為您服務的？"
            return cell
            
        } else if indexPath.row % 2 == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Customer Cell", for: indexPath) as? CustomerTableViewCell else {
                return UITableViewCell()
            }
            
            questionIndex = (indexPath.row - 1) / 2
            cell.messageLable.text = ownerQuestion[questionIndex]
            return cell
            
        } else {
            
            return UITableViewCell()
            
        }

    }
}
