//
//  FreeDeliveryTableViewCell.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/4.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class FreeDeliveryTableViewCell: UITableViewCell {

  @IBOutlet weak var freeImage: UIImageView!
  @IBOutlet weak var getAction: UIButton!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  @IBAction func getActionFree(_ sender: Any) {
  }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
