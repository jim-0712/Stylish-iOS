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
//    getData()
    cartTable.delegate = self
    cartTable.dataSource = self
    cartTable.separatorStyle = .none
    
  }
  
  func getData() {
      let configuration = URLSessionConfiguration.default
      let session = URLSession(configuration: configuration)
  //    let shoppingCart = URL(string: "https://williamyhhuang.com/api/1.0/search?email=won54chan@gmail.com")!
      let email = UserDefaults.standard.value(forKey: "email") as? String
      let shoppingCart = URL(string: "https://williamyhhuang.com/api/1.0/search?email=\(email!)")!
      var request = URLRequest(url: shoppingCart)
      request.httpMethod = "GET"
 
  //    request.value(forHTTPHeaderField: email!)
      
      let task = session.dataTask(with: request) {(data, response, error)  in
        guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {return}
        
        guard let data = data else {
          return
        }
        let decoder = JSONDecoder()
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
          let result  = try decoder.decode(HistoryList.self, from: data)
          self.storeManJim.historyData = [result]
          for count in 0 ..< result.total.count {
            self.total += result.total[count]
          }
          self.storeManJim.totalMoney = self.total
          print(result)
        } catch {
          
        }
      }
      task.resume()
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return storeManJim.historyData[0].orderlist.count

  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "history", for: indexPath) as? HistoryTableViewCell else { return UITableViewCell()}
    
    cell.accountLabel.text = "數量：\(storeManJim.historyData[0].orderlist[indexPath.row].list[0].qty)"
    cell.numberLabel.text = "訂單編號\(storeManJim.historyData[0].orderlist[indexPath.row].number)"
    cell.productLabel.text = storeManJim.historyData[0].orderlist[indexPath.row].list[0].name
    cell.sizeLabel.text = storeManJim.historyData[0].orderlist[indexPath.row].list[0].size
    let colorUrl = storeManJim.historyData[0].orderlist[indexPath.row].list[0].color
    cell.colorBlock.backgroundColor = UIColor.hexStringToUIColor(hex: colorUrl)
    cell.moneyLabel.text = "價格：\(storeManJim.historyData[0].orderlist[indexPath.row].list[0].price)"
    let imageURL = URL(string: storeManJim.historyData[0].orderlist[indexPath.row].list[0].mainimage)
    cell.pictureView.kf.setImage(with: imageURL)
    cell.refundButton.isEnabled = false
    cell.refundButton.alpha = 0.0
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 160
  }
}
