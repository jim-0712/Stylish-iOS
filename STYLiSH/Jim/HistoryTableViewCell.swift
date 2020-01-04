//
//  HistoryTableViewCell.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/3.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
  
  @IBOutlet weak var pictureView: UIImageView!
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var productLabel: UILabel!
  @IBOutlet weak var colorBlock: UIView!
  @IBOutlet weak var sizeLabel: UILabel!
  @IBOutlet weak var accountLabel: UILabel!
  @IBOutlet weak var moneyLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
