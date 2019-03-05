//
//  AmountSelectionCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/5.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class AmountSelectionCell: UITableViewCell {
    
    @IBOutlet weak var selectionView: TrolleySelectionView!
    
    @IBOutlet weak var stockLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    
        selectionView.isEnable(false)
    }
    
    func layoutCell(variant: Variant?) {
        
        guard let data = variant else {
            
            selectionView.isEnable(false)
            
            stockLbl.isHidden = true
            
            return
        }
        
        selectionView.isEnable(true)
        
        stockLbl.isHidden = false
        
        stockLbl.text = "庫存：\(data.stock)"
        
        selectionView.inputField.text = "1"
    }

}
