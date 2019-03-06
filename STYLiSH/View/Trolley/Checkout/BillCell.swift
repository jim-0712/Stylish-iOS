//
//  BillCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class BillCell: UITableViewCell {

    @IBOutlet weak var inputField: STBaseTextField!
    
    @IBOutlet weak var productPriceLbl: UILabel!
    
    @IBOutlet weak var freightLbl: UILabel!
    
    @IBOutlet weak var amountLbl: UILabel!
    
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func layoutCell(amount: String, productPrice: Int, freightPrice: Int = 60) {
        
        amountLbl.text = "總計 ( \(amount) 樣商品)"
        
        productPriceLbl.text = "NT$ \(productPrice)"
        
        freightLbl.text = "NT$ \(freightPrice)"
        
        totalPriceLbl.text = "NT$ \(freightPrice + productPrice)"
    }

}
