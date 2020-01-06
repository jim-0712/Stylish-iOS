//
//  RefundTableViewCell.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/6.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit


protocol RefundManager: AnyObject{
  func refundMan(viewCell: RefundTableViewCell, isClick: Bool )
}

class RefundTableViewCell: UITableViewCell {

  var number = 0
  
  var delegate: RefundManager?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

  
  @IBAction func tapRefund(_ sender: Any) {
    
    self.delegate?.refundMan(viewCell: self, isClick: true)
    
  }
  
  
  @IBOutlet weak var pictureView: UIImageView!
   @IBOutlet weak var numberLabel: UILabel!
   @IBOutlet weak var productLabel: UILabel!
   @IBOutlet weak var colorBlock: UIView!
   @IBOutlet weak var sizeLabel: UILabel!
   @IBOutlet weak var accountLabel: UILabel!
   @IBOutlet weak var moneyLabel: UILabel!
   @IBOutlet weak var refundButton: UIButton!
}
