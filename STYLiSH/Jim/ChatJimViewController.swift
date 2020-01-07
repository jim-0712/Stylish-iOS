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
        
        guard let userEmail = UserDefaults.standard.value(forKey: "email") as? String else {return}
        
        super.viewDidLoad()
        
        IQKeyboardManager.shared.enable = true
        
        self.navigationItem.title = "Chat Room"
        
        emailLabel.text = "Hi, \(userEmail)!"
        
        self.answerImage.image = UIImage(named: "returned")
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var reallyQuestionText: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var answerImage: UIImageView!
    @IBAction func sendAction(_ sender: Any) {
        
        postQuestion(comment: reallyQuestionText.text!)
    }
    
    var questionType = ""
    @IBAction func questionSegAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0 :
            questionType = "0"
            self.answerImage.image = UIImage(named: "returned")
        case 1 :
            questionType = "1"
            self.answerImage.image = UIImage(named: "sizes")
        case 2 :
            questionType = "2"
            self.answerImage.image = UIImage(named: "process")
        default:
            questionType = "3"
            self.answerImage.image = UIImage(named: "deliver")
        }
    }
    
    func postQuestion(comment: String) {
        
        guard let userEmail = UserDefaults.standard.value(forKey: "email") as? String else {return}
        
        //        let header = ["email": userEmail, "Content-Type": "application/json"]
        let url = URL(string: "https://williamyhhuang.com/api/1.0/service")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(userEmail, forHTTPHeaderField: "email")
        
        let customerQuest = CustomerQuest(comment: reallyQuestionText.text!)
        let customerData = CustomerData(data: customerQuest)
        
        let encoder = JSONEncoder()
        
        let postData = try? encoder.encode(customerData)
//        let postData = try? JSONSerialization.data(withJSONObject: customerData, options: .prettyPrinted)
        
//        let parameters = ["data": [
//            ["comment": reallyQuestionText.text]]]
//        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let response = response as? HTTPURLResponse, let data = data {
                print("Status code: \(response.statusCode)")
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode(ServiceData.self, from: data)
                    ServiceManager.shared.number.append(result.serviceNumber)
                    print(result.serviceNumber)
                } catch {
                    print(error)
                }
                
            }
        }.resume()
        
    }
}
