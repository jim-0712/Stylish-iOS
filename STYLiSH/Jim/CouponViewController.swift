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
  var storeManJim = StoreJimS.sharedJim
  var tenpercent = 0
  var freeShip = 0
  var totalCount = 0
  override func viewDidLoad() {
    super.viewDidLoad()
    couponTable.delegate = self
    couponTable.dataSource = self
    couponTable.separatorStyle = .none
    
    tenpercent = storeManJim.lottery[0].coupon.tenpercent.count
    freeShip = storeManJim.lottery[0].coupon.shipfree.count
    totalCount = tenpercent + freeShip
    // Do any additional setup after loading the view.
  }
  
}

extension CouponViewController : UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return totalCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if totalCount == 0 {
      return UITableViewCell()
    }else if tenpercent == 0 && freeShip != 0 {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "freeDe", for: indexPath) as? FreeDeliveryTableViewCell else{ return UITableViewCell() }
            return cell
    }else if freeShip == 0 && tenpercent != 0 {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "coupon", for: indexPath) as? CouponTableViewCell else{ return UITableViewCell() }
            return cell
    }else if indexPath.row < tenpercent{
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "freeDe", for: indexPath) as? FreeDeliveryTableViewCell else{ return UITableViewCell() }
      return cell
    }else{
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "coupon", for: indexPath) as? CouponTableViewCell else{ return UITableViewCell() }
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
}
