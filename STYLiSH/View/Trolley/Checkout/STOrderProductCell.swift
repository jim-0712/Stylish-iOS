//
//  STOrderProductCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/7/25.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class STOrderProductCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var productSizeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func layoutCell(
        imageUrl: String?,
        title: String?,
        color: String?,
        size: String?,
        price: String?,
        pieces: String?
    ) {
        
        productImageView.loadImage(imageUrl)
        
        productTitleLabel.text = title
        
        productSizeLabel.text = size

        priceLabel.text = price
        
        orderNumberLabel.text = pieces
        
        guard let colorCode = color else {
            
            colorView.backgroundColor = UIColor.white
            
            return
        }
        
        colorView.backgroundColor = UIColor.hexStringToUIColor(hex: colorCode)
    }
}
