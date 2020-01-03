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
  
  @IBAction func backAction(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  let emptyView = UIView()
  var backButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = UIColor.green
    return button
  }()

    override func viewDidLoad() {
        super.viewDidLoad()
      
      setUpTable()
      
        // Do any additional setup after loading the view.
    }
  func setUpTable(){
    cartTable.delegate = self
    cartTable.dataSource = self
    cartTable.separatorStyle = .none
    emptyView.addSubview(backButton)
    cartTable.tableHeaderView = emptyView
    cartTable.tableHeaderView?.frame.size.height = 100
    cartTable.backgroundColor = .white
    cartTable.translatesAutoresizingMaskIntoConstraints = false
    backButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backButton.trailingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: -16),
      backButton.heightAnchor.constraint(equalToConstant: 40),
      backButton.widthAnchor.constraint(equalToConstant: 40),
      backButton.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 16)
    ])
  }
  
  func getMarketingHots() {
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    let shoppingCart = URL(string: "")!
    var request = URLRequest(url: shoppingCart)
    request.httpMethod = "GET"
    
    let task = session.dataTask(with: request) {(data, response, error)  in
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200 else {return}
      
      guard let data = data else {
        return
      }
      let decoder = JSONDecoder()
      do {
        let result  = try decoder.decode(Data.self, from: data)
        
      } catch {
        
      }
    }
    task.resume()
  }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as? HistoryTableViewCell else{return UITableViewCell()}
    return cell
  }
}
