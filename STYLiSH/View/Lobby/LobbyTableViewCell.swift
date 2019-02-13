//
//  LobbyTableViewCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class LobbyTableViewCell: UITableViewCell {

    @IBOutlet weak var singleImgView: UIImageView!
    
    @IBOutlet weak var multipleImgView1: UIImageView!
    
    @IBOutlet weak var multipleImgView2: UIImageView!
    
    @IBOutlet weak var multipleImgView3: UIImageView!
    
    @IBOutlet weak var multipleImgView4: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func singlePage(img: String) {
        
        singleImgView.alpha = 1.0
    
        
    }
    
    func multiplePages(imgs: [String]) {
        
        singleImgView.alpha = 0.0
        
        
    }
}
