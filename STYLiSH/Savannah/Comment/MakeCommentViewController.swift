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
    
    override func viewDidLoad() {
        guard let userEmail = UserDefaults.standard.value(forKey: "email") as? String else {return}
        userLabel.text = "Hi, \(userEmail)"
        super.viewDidLoad()
        self.navigationItem.title = "Share Comments"

        // Do any additional setup after loading the view.
    }
}
