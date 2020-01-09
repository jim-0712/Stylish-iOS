//
//  MakeCommentViewController.swift
//  STYLiSH
//
//  Created by Savannah Su on 2020/1/6.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class MakeCommentViewController: UIViewController {
    
    //guard let userEmail = UserDefaults.standard.value(forKey: "email") as? String else {return}
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var oneStarBtn: UIButton!
    @IBOutlet weak var twoStarsBtn: UIButton!
    @IBOutlet weak var threeStarsBtn: UIButton!
    @IBOutlet weak var fourStarsBtn: UIButton!
    @IBOutlet weak var fiveStarsBtn: UIButton!
    
    var orderNumber = ""
    var productID = ""
    var star = ""
    
    @IBAction func oneStarBtn(_ sender: Any) {
        oneStarBtn.isSelected = true
        twoStarsBtn.isSelected = false
        threeStarsBtn.isSelected = false
        fourStarsBtn.isSelected = false
        fiveStarsBtn.isSelected = false
        
        star = "1"
    }
    @IBAction func twoStarsBtn(_ sender: Any) {
        oneStarBtn.isSelected = true
        twoStarsBtn.isSelected = true
        threeStarsBtn.isSelected = false
        fourStarsBtn.isSelected = false
        fiveStarsBtn.isSelected = false
        
        star = "2"
    }
    @IBAction func threeStarsBtn(_ sender: Any) {
        oneStarBtn.isSelected = true
        twoStarsBtn.isSelected = true
        threeStarsBtn.isSelected = true
        fourStarsBtn.isSelected = false
        fiveStarsBtn.isSelected = false
        
        star = "3"
    }
    @IBAction func fourStarsBtn(_ sender: Any) {
        oneStarBtn.isSelected = true
        twoStarsBtn.isSelected = true
        threeStarsBtn.isSelected = true
        fourStarsBtn.isSelected = true
        fiveStarsBtn.isSelected = false
        
        star = "4"
    }
    @IBAction func fiveStarsBtn(_ sender: Any) {
        oneStarBtn.isSelected = true
        twoStarsBtn.isSelected = true
        threeStarsBtn.isSelected = true
        fourStarsBtn.isSelected = true
        fiveStarsBtn.isSelected = true
        
        star = "5"
    }
    
    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var addPhotosBtn: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBAction func postButton(_ sender: Any) {
        
        if oneStarBtn.isSelected == true && commentTF.text != nil {
            
            postButton.isEnabled = false
            postComment()
            postAlert()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismiss(animated: true, completion: nil)
            }
            
        } else {
            return
        }
            
    }
    
    override func viewDidLoad() {
        
        guard let userEmail = UserDefaults.standard.value(forKey: "email") as? String else {return}
        userLabel.text = "Hi, \(userEmail)"
        
        super.viewDidLoad()
        self.navigationItem.title = "Share Comments"
        
        addPhotosBtn.isEnabled = false
        
        commentTF.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        postButton.isEnabled = false
    }

    func postComment() {
        
        guard let userEmail = UserDefaults.standard.value(forKey: "email") as? String else {return}
        
        var request = URLRequest(url: URL(string: "https://williamyhhuang.com/api/1.0/comment")!)
        
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = [
            "email": "\(userEmail)",
            "Content-Type": "application/json"
        ]
        
        let bodyDict: [String: Any] = [
            "data": [
                "order_number": "\(orderNumber)",
                "product_id": "\(productID)",
                "star": "\(star)",
                "comment": "\(String(describing: commentTF.text))"
            ]
        ]
        let data = try? JSONSerialization.data(withJSONObject: bodyDict, options: .prettyPrinted)
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                
                print("Downcast HTTPURLResponse fail")
                
                return
            }
            
            guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300
                else {
                    print("Status Failed! \(httpResponse.statusCode)")
                    return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ReturnObject.self, from: data!)
                print(result)
            } catch {
                print(error)
            }
            
        }).resume()
        
    }
    
    struct ReturnObject: Codable {
        let message: String
    }
    
    func postAlert() {
        
        let alert = UIAlertController(title: "New Comment Posted!", message: "Thank you for your sharing.", preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

extension MakeCommentViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if commentTF != nil && oneStarBtn.isSelected == true {
            postButton.isEnabled = true
        } else {
            return
        }
    }
    
}
