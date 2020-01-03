//
//  PointViewController.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/3.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class PointViewController: UIViewController {
  
  @IBOutlet weak var headerGrayView: UIView!
  @IBOutlet weak var logoImage: UIImageView!
  @IBOutlet weak var mileStoneLabel: UILabel!
  @IBOutlet weak var mileStoneView: UIView!
  @IBOutlet weak var pointLabel: UILabel!
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var loadingWidthView: NSLayoutConstraint!
  
  @IBAction func backAction(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
   
  override func viewDidLoad() {
    super.viewDidLoad()
    let targetWidth = backgroundView.frame.size.width
    
    mileStoneView.backgroundColor = .red
    
//    UIView.animate(withDuration: 0.5,
//                            delay: 0,
//                            options: [.repeat, .autoreverse],
//                            animations: {
//                              self.loadingWidthView.constant = 500
//                              self.mileStoneView.alpha = 0.0
//                              self.view.layoutIfNeeded()
//                            },
//                            completion: nil)
    

    
//    UIView.animate(withDuration: 0.5) {
//      loadingWidthView.constant = 200
//    }
    
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
        UIView.animate(withDuration: 0.5,
                                delay: 0,
                                options: [.repeat, .autoreverse],
                                animations: {
                                  self.loadingWidthView.constant = 500
                                  self.mileStoneView.alpha = 0.0
                                  self.view.layoutIfNeeded()
                                },
                                completion: nil)
  }
  
  
}
