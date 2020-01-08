//
//  MakeCommentViewController.swift
//  STYLiSH
//
//  Created by Savannah Su on 2020/1/6.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class MakeCommentViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var oneStarBtn: UIButton!
    @IBOutlet weak var twoStarsBtn: UIButton!
    @IBOutlet weak var threeStarsBtn: UIButton!
    @IBOutlet weak var fourStarsBtn: UIButton!
    @IBOutlet weak var fiveStarsBtn: UIButton!
    
    var star = ""
    
    @IBAction func oneStarBtn(_ sender: Any) {
        oneStarBtn.isSelected = true
        
        star = "1"
    }
    @IBAction func twoStarsBtn(_ sender: Any) {
        oneStarBtn.isSelected = true
        twoStarsBtn.isSelected = true
        
        star = "2"
    }
    @IBAction func threeStarsBtn(_ sender: Any) {
        oneStarBtn.isSelected = true
        twoStarsBtn.isSelected = true
        threeStarsBtn.isSelected = true
        
        star = "3"
    }
    @IBAction func fourStarsBtn(_ sender: Any) {
        oneStarBtn.isSelected = true
        twoStarsBtn.isSelected = true
        threeStarsBtn.isSelected = true
        fourStarsBtn.isSelected = true
        
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
    @IBAction func postButton(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        
        guard let userEmail = UserDefaults.standard.value(forKey: "email") as? String else {return}
        userLabel.text = "Hi, \(userEmail)"
        super.viewDidLoad()
        self.navigationItem.title = "Share Comments"

        // Do any additional setup after loading the view.
    }
}
