//
//  LobbyViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit
import  UserNotifications

class LobbyViewController: STBaseViewController {
  
  var storeManJim = StoreJimS.sharedJim
  let provider = UserProvider()
  let manager = ProfileManager()
  var total = 0
  let jimManager = JimManager()
  
  @IBOutlet weak var lobbyView: LobbyView! {
    
    didSet {
      
      lobbyView.delegate = self
    }
  }
  
  var datas: [PromotedProducts] = [] {
    
    didSet {
      
      lobbyView.reloadData()
    }
  }
  
  let marketProvider = MarketProvider()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.titleView = UIImageView(image: UIImage.asset(.Image_Logo02))
    lobbyView.beginHeaderRefresh()
    
    NotificationCenter.default.addObserver(self, selector: #selector(reFetchData), name: Notification.Name("reloadTicket"), object: nil)
    
    guard let data = UserDefaults.standard.value(forKey: "email") else { return }
    getData()
    UserDefaults.standard.set(false, forKey: "sign")
    getRefundData()
  }

  @objc func reFetchData(){
    
    lotteryDataNew()
    
  }
  
  
  func lotteryDataNew() {
      let configuration = URLSessionConfiguration.default
      let session = URLSession(configuration: configuration)
      let email = UserDefaults.standard.value(forKey: "email") as? String
  //  let newlottery = URL(string: "https://yssites.com/api/1.0/points")!
      let newlottery = URL(string: "https://williamyhhuang.com/api/1.0/points")!
      var request = URLRequest(url: newlottery)
      request.httpMethod = "GET"
      request.addValue(email!, forHTTPHeaderField: "email")
      
      let task = session.dataTask(with: request) {(data, response, error)  in
        guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {return}
        
        guard let data = data else {
          return
        }
        let decoder = JSONDecoder()
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
          let result  = try decoder.decode(Lottery.self, from: data)
          self.storeManJim.lottery = [result]
          self.getRefundDataNew()
           NotificationCenter.default.post(name: Notification.Name("reloadCoupon"), object: nil)
          
          print(result)
        } catch {
        }
      }
      task.resume()
    }
  
  // MARK: - Action
  func fetchData() {
    
    marketProvider.fetchHots(completion: { [weak self] result in
      
      switch result {
        
      case .success(let products):
        
        self?.datas = products
        
      case .failure:
        
        LKProgressHUD.showFailure(text: "讀取資料失敗！")
      }
    })
  }
  
  func lotteryData() {
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    let email = UserDefaults.standard.value(forKey: "email") as? String
//  let newlottery = URL(string: "https://yssites.com/api/1.0/points")!
    let newlottery = URL(string: "https://williamyhhuang.com/api/1.0/points")!
    var request = URLRequest(url: newlottery)
    request.httpMethod = "GET"
    request.addValue(email!, forHTTPHeaderField: "email")
    
    let task = session.dataTask(with: request) {(data, response, error)  in
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200 else {return}
      
      guard let data = data else {
        return
      }
      let decoder = JSONDecoder()
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let result  = try decoder.decode(Lottery.self, from: data)
        self.storeManJim.lottery = [result]
        print(result)
      } catch {
      }
    }
    task.resume()
  }
  
  func getRefundData() {
    guard let email = UserDefaults.standard.value(forKey: "email") else {return }
    jimManager.canRefundData (completion: { result in
        
        switch result {
            
        case .success(let recommands):
     
            print("Ya")
            
        case .failure(let error):
        
            print(error)
        }
        
    })
  }
  
  func getRefundDataNew() {
    guard let email = UserDefaults.standard.value(forKey: "email") else {return }
    jimManager.canRefundData (completion: { result in
        
        switch result {
            
        case .success(let recommands):
      
            NotificationCenter.default.post(name: Notification.Name("refundNew"), object: nil)
            self.getDataNew()
            print("Ya")
            
        case .failure(let error):
        
            print(error)
        }
        
    })
  }
  
  func getDataNew() {
    
      let configuration = URLSessionConfiguration.default
      let session = URLSession(configuration: configuration)
      let email = UserDefaults.standard.value(forKey: "email") as? String
      let shoppingCart = URL(string: "https://williamyhhuang.com/api/1.0/search")!
      var request = URLRequest(url: shoppingCart)
      request.httpMethod = "GET"
      request.addValue(email!, forHTTPHeaderField: "email")
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
          NotificationCenter.default.post(name: Notification.Name("historyNew"), object: nil)
        } catch {
        }
      }
      task.resume()
    }
  
  func getData() {
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    let email = UserDefaults.standard.value(forKey: "email") as? String
    let shoppingCart = URL(string: "https://williamyhhuang.com/api/1.0/search")!
    var request = URLRequest(url: shoppingCart)
    request.httpMethod = "GET"
    request.addValue(email!, forHTTPHeaderField: "email")
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
        self.lotteryData()
//        print(result)
      } catch {
      }
    }
    task.resume()
  }
}

extension LobbyViewController: LobbyViewDelegate {
  
  func triggerRefresh(_ lobbyView: LobbyView) {
    
    fetchData()
  }
  
  // MARK: - UITableViewDataSource and UITableViewDelegate
  func numberOfSections(in tableView: UITableView) -> Int {
    
    return datas.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return datas[section].products.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(
      withIdentifier: String(describing: LobbyTableViewCell.self),
      for: indexPath
    )
    
    guard let lobbyCell = cell as? LobbyTableViewCell else { return cell }
    
    let product = datas[indexPath.section].products[indexPath.row]
    
    if indexPath.row % 2 == 0 {
      
      lobbyCell.singlePage(
        img: product.mainImage,
        title: product.title,
        description: product.description
      )
      
    } else {
      
      lobbyCell.multiplePages(
        imgs: product.images,
        title: product.title,
        description: product.description
      )
    }
    
    return lobbyCell
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 67.0 }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 258.0 }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 0.01 }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    guard let headerView = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: String(describing: LobbyTableViewHeaderView.self)
      ) as? LobbyTableViewHeaderView else {
        return nil
    }
    
    headerView.titleLabel.text = datas[section].title
    
    return headerView
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let detailVC = UIStoryboard
      .product
      .instantiateViewController(
        withIdentifier: String(describing: ProductDetailViewController.self)
      ) as? ProductDetailViewController else {
        
        return
    }
    
    detailVC.product = datas[indexPath.section].products[indexPath.row]
    
    show(detailVC, sender: nil)
  }
}
