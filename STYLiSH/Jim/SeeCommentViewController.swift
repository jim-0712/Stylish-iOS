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
        // Do any additional setup after loading the view.
    }
    
  var apple = [HistoryList]() {
    didSet {
      if apple.isEmpty {
         
      }else{
        
        commentTable.reloadData()
      }
    }
  }
  
  @IBOutlet weak var commentTable: UITableView!

}

extension SeeCommentViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return apple.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  
}
