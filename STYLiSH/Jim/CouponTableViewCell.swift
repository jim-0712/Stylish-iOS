//
//  CouponTableViewCell.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/4.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class CouponTableViewCell: UITableViewCell {

  @IBOutlet weak var nintyPercentLabel: UILabel!
  @IBOutlet weak var percentLabel: UIImageView!
  @IBOutlet weak var getButton: UIButton!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
