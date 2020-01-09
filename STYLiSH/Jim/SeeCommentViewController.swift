//
//  SeeCommentViewController.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/7.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class SeeCommentViewController: UIViewController {
  
  let jimManager = JimManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    commentTable.delegate = self
    commentTable.dataSource = self
     getCommentBack()
    if commentDataBack.isEmpty {
      DispatchQueue.main.async {
        LKProgressHUD.show()
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        LKProgressHUD.dismiss()
      }
    }
    // Do any additional setup after loading the view.
  }
  
  var productID = 0
  var commentDataBack = [BackComment]() {
    didSet {
      if commentDataBack.isEmpty {
    
      } else {
        DispatchQueue.main.async {
          self.commentTable.reloadData()
          LKProgressHUD.dismiss()
        }
      }
    }
  }
  
  @IBOutlet weak var commentTable: UITableView!
  
  func getCommentBack() {
    
    jimManager.productCommentReturn { result  in
      
      switch result {
        
      case .success(let data):
        
        self.commentDataBack = data
      
      case .failure(let error):
        
        print(error)
        
      }
    }
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
    
    if commentDataBack.count == 0 {
      
      return UITableViewCell()
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentTable", for: indexPath) as? CommentTableViewCell else {return UITableViewCell() }
      guard let star = Int(commentDataBack[indexPath.row].star) else {
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
