//
//  CouponTableViewCell.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/4.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class CouponTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var couponImage: UIImageView!
    @IBOutlet weak var couponLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var descripLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
