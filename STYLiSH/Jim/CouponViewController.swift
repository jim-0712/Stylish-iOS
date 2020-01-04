//
//  CouponViewController.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/4.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class CouponViewController: UIViewController {

  @IBOutlet weak var couponTable: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    couponTable.delegate = self
    couponTable.dataSource = self
    couponTable.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    
}

extension CouponViewController : UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row % 2 == 0 {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "coupon", for: indexPath) as? CouponTableViewCell else{ return UITableViewCell() }
    return cell
    }else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "freeDe", for: indexPath) as? FreeDeliveryTableViewCell else{ return UITableViewCell() }
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
}
