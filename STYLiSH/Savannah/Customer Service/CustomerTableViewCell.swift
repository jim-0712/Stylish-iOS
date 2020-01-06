//
//  CustomerTableViewCell.swift
//  STYLiSH
//
//  Created by Savannah Su on 2020/1/3.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLable: UILabel!
    @IBOutlet weak var customerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
