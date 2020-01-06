//
//  RefundViewController.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/6.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class RefundViewController: UIViewController {
  
  var total = 0
  var storeManJim = StoreJimS.sharedJim
  let jimManager = JimManager()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    refundTable.delegate = self
    refundTable.dataSource = self
    // Do any additional setup after loading the view.
  }
  @IBOutlet weak var refundTable: UITableView!
}

extension RefundViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 170
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return StoreJimS.sharedJim.refundData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "refundcell", for: indexPath) as? RefundTableViewCell else { return UITableViewCell()}
    
    cell.accountLabel.text = "數量：\(storeManJim.refundData[indexPath.row].details.list[0].qty)"
    cell.numberLabel.text = "訂單編號\(storeManJim.refundData[indexPath.row].details.list[0].id)"
    cell.productLabel.text = storeManJim.refundData[indexPath.row].details.list[0].name
    cell.sizeLabel.text = storeManJim.refundData[indexPath.row].details.list[0].size
    let colorUrl = storeManJim.refundData[indexPath.row].details.list[0].color
    cell.colorBlock.backgroundColor = UIColor.hexStringToUIColor(hex: colorUrl)
    cell.moneyLabel.text = "價格：\(storeManJim.refundData[indexPath.row].details.list[0].price)"
//    let imageURL = URL(string: storeManJim.refundData[0].details[indexPath.row].list[0].mainimage)
//    cell.pictureView.kf.setImage(with: imageURL)
    cell.refundButton.isEnabled = true
    cell.refundButton.alpha = 1.0
    guard let transferNumber =  Int(storeManJim.refundData[indexPath.row].details.list[0].id) else {return cell}
    cell.number = transferNumber
    cell.delegate = self
    return cell
    
    return UITableViewCell()
  }
}

extension RefundViewController : RefundManager {
  func refundMan(viewCell: RefundTableViewCell, isClick: Bool) {
    guard let vc = UIStoryboard(name: "second", bundle: nil).instantiateViewController(identifier: "why") as? WhyViewController else {
        return
      }
      vc.navigationController?.pushViewController(vc, animated: true)
      show(vc, sender: nil)
    }
  }
  

