//
//  STHideNavigationBarController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/3.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class STHideNavigationBarController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBAction func popBack(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
}
