//
//  PointViewController.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/3.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class PointViewController: UIViewController {
  
  @IBOutlet weak var headerGrayView: UIView!
  @IBOutlet weak var logoImage: UIImageView!
  @IBOutlet weak var mileStoneLabel: UILabel!
  @IBOutlet weak var mileStoneView: UIView!
  @IBOutlet weak var pointLabel: UILabel!
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var loadingWidthView: NSLayoutConstraint!
  @IBOutlet weak var vipImage: UIImageView!
  @IBOutlet weak var memberLabel: UILabel!
  @IBOutlet weak var ninetyLabel: UILabel!
  @IBOutlet weak var percentLabel: UIImageView!
  @IBOutlet weak var getTicketButton: UIButton!
  @IBOutlet weak var cheatView: UIView!
  @IBOutlet weak var ticketCountLabel: UILabel!
  
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var nowLabel: UILabel!
  
  var storeManJim = StoreJimS.sharedJim
  @IBAction func backAction(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  var useWidth : CGFloat = 0
  var money = 0
  var percent: CGFloat = 0.0
  var count = 0
  @IBOutlet weak var myGodWidth: NSLayoutConstraint!
  @IBOutlet weak var myGodView: UIView!
  @IBOutlet weak var stackViewCon: NSLayoutConstraint!
  override func viewDidLoad() {
    super.viewDidLoad()
    let targetWidth = backgroundView.frame.size.width
    money = storeManJim.totalMoney
    useWidth = targetWidth
    mileStoneView.backgroundColor = .lightGray
    pointLabel.text = "總金額：\(money)"
    
    count = money / 10000
    ticketCountLabel.text = "您有\(count)張折價券"
    memberLevel()
  }
  @IBAction func getTickAction(_ sender: Any) {
    if count == 0 {
      ticketCountLabel.text = "沒折價券了傻逼"
      getTicketButton.isEnabled = false
    } else {
      getTicketButton.isEnabled = true
      count -= 1
      NotificationCenter.default.post(name: Notification.Name("ticket"), object: nil)
      ticketCountLabel.text = "您有\(count)張折價券"
    }
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.animate(withDuration: 2,
                   delay: 0,
                   options: [.repeat, .autoreverse],
                   animations: {
                    self.mileStoneView.alpha = 0.0
                    self.view.layoutIfNeeded()
    },
                   completion: nil)
    
    UIView.animate(withDuration: 2,
                   delay: 0,
                   options: [.curveLinear] ,
                   animations: {
                    self.myGodWidth.constant = 300
                    // self.myGodView.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.myGodView.transform = CGAffineTransform(translationX: 0.6 * self.useWidth, y: 0)
                    self.myGodView.backgroundColor = .red
    },
                   completion: nil)
    
    UIView.animate(withDuration: 1.5,
                   delay: 0,
                   options: [.repeat, .autoreverse],
                   animations: { [weak self] in
                    self?.vipImage.frame.size.height *= 2.0
                    self?.vipImage.frame.size.width *= 2.0

      }, completion: nil)
    
  }
  
  func memberLevel() {
    if money < 4999 {
      vipImage.image = UIImage(named: "popo")
      memberLabel.text = "一般會員"
      let cash = 4999 - money
      mileStoneLabel.text = "距離下一等級差\(cash)元"
      targetLabelSett(now: 0, target: 4999)
      percent = CGFloat(money / 4999)
    } else if 5000 <= money && money <= 10000 {
      vipImage.image = UIImage(named: "gold")
      let cash = 10000 - money
      mileStoneLabel.text = "距離下一等級差\(cash)元"
      memberLabel.text = "黃金會員"
      targetLabelSett(now: 5000, target: 10000)
      percent = CGFloat(money / 10000)
    } else if 10001 <= money && money <= 20000 {
      vipImage.image = UIImage(named: "white")
      let cash = 20000 - money
      mileStoneLabel.text = "距離下一等級差\(cash)元"
      memberLabel.text = "白金會員"
      targetLabelSett(now: 10001, target: 20000)
      percent = CGFloat(money / 20000)
    } else {
      vipImage.image = UIImage(named: "diamond")
      memberLabel.text = "鑽石會員"
    }
  }
  
  
  func targetLabelSett(now: Int,target: Int){
    nowLabel.text = "\(now)元"
    targetLabel.text = "\(target)元"
  }
  
  func postLoginCall(){
    let shoppingCart = URL(string: "")!
    var request = URLRequest(url: shoppingCart)
    request.httpMethod = "POST"
    let postString = "1"
    print(postString)
    request.httpBody = postString.data(using: String.Encoding.utf8)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
      guard error == nil else {
        print("error=\(error)")
        return
      }
    }
    task.resume()
  }
}
