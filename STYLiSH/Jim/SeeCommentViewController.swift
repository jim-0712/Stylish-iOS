//
//  SeeCommentViewController.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/7.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class SeeCommentViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    commentTable.delegate = self
    commentTable.dataSource = self
    commentDataDown()
    if commentDataBack.isEmpty {
      DispatchQueue.main.async {
        LKProgressHUD.show()
      }
    }
    // Do any additional setup after loading the view.
  }
  
  var productID = 0
  var commentDataBack = [BackComment]() {
    didSet {
      if commentDataBack.isEmpty {
    
      }else{
        DispatchQueue.main.async {
          self.commentTable.reloadData()
          LKProgressHUD.dismiss()
        }
      }
    }
  }
  
  @IBOutlet weak var commentTable: UITableView!
  
  
  func commentDataDown() {
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    //    let email = UserDefaults.standard.value(forKey: "email") as? String
    let commentBack = URL(string: "https://williamyhhuang.com/api/1.0/comment")!
    var request = URLRequest(url: commentBack)
    request.httpMethod = "GET"
    let prodID = String(productID)
    request.addValue(prodID, forHTTPHeaderField: "productid")
    
    let task = session.dataTask(with: request) {(data, response, error)  in
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200 else {return}
      
      guard let data = data else {
        return
      }
      let decoder = JSONDecoder()
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let result  = try decoder.decode([BackComment].self, from: data)
        self.commentDataBack = result
        
        print(result)
      } catch {
        print(error)
      }
    }
    task.resume()
  }
}

extension SeeCommentViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return commentDataBack.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 180
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if commentDataBack.count == 0{
      
      return UITableViewCell()
    }else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentTable", for: indexPath) as? CommentTableViewCell else {return UITableViewCell()}
      guard let star = Int(commentDataBack[indexPath.row].star) else{
        return cell
      }
      switch star {
      case 1:
        cell.starBtn.isSelected = true
      case 2:
        cell.starBtn.isSelected = true
        cell.starBtn2.isSelected = true
      case 3:
        cell.starBtn.isSelected = true
        cell.starBtn2.isSelected = true
        cell.starBtn3.isSelected = true
      case 4:
        cell.starBtn.isSelected = true
        cell.starBtn2.isSelected = true
        cell.starBtn3.isSelected = true
        cell.starBtn4.isSelected = true
      case 5:
        cell.starBtn.isSelected = true
        cell.starBtn2.isSelected = true
        cell.starBtn3.isSelected = true
        cell.starBtn4.isSelected = true
        cell.starBtn5.isSelected = true
      default:
        cell.starBtn.isSelected = false
      }
      cell.userIdLabel.text = "會員編號\(commentDataBack[indexPath.row].userid)"
      cell.commentTextView.text = commentDataBack[indexPath.row].comment
      cell.timeLabel.text = "發布時間\(commentDataBack[indexPath.row].time)"
      return cell
    }
  }
}
