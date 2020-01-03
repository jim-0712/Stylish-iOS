//
//  HistoryViewController.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/3.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit
import Kingfisher
import JGProgressHUD


class HistoryViewController: UIViewController {
  
  @IBOutlet weak var cartTable: UITableView!
  var total = 0
  var storeManJim = StoreJimS.sharedJim
  
  @IBAction func backAction(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  let emptyView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.green
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    cartTable.delegate = self
    cartTable.dataSource = self
    cartTable.separatorStyle = .none
    
  }
  
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return storeManJim.historyData[0].list.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "history", for: indexPath) as? HistoryTableViewCell else { return UITableViewCell()}
    cell.accountLabel.text = "數量：\(storeManJim.historyData[0].list[0].product[indexPath.row].qty)"
    cell.numberLabel.text = "訂單編號\(storeManJim.historyData[0].list[0].orderid)"
    cell.productLabel.text = storeManJim.historyData[0].list[0].product[indexPath.row].name
    cell.sizeLabel.text = storeManJim.historyData[0].list[0].product[indexPath.row].size
    let colorUrl = storeManJim.historyData[0].list[0].product[indexPath.row].color.colorcode
    cell.colorBlock.backgroundColor = UIColor.hexStringToUIColor(hex: colorUrl)
    cell.moneyLabel.text = "價格：\(storeManJim.historyData[0].list[0].product[indexPath.row].price)"
    let imageURL = URL(string: storeManJim.historyData[0].list[0].product[indexPath.row].picture)
    cell.pictureView.kf.setImage(with: imageURL)
    
//    for count1 in 0 ..< storeManJim.historyData[0].list.count{
//      for count2 in 0 ..< storeManJim.historyData[0].list[count1].product.count {
//        guard let money = Int(storeManJim.historyData[0].list[count1].product[count2].price) else {return cell}
//        total += money
//      }
//    }
//    storeManJim.totalMoney = total
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 160
  }
}
