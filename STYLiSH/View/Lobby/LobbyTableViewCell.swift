//
//  LobbyTableViewCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit
import Kingfisher

class LobbyTableViewCell: UITableViewCell {

    @IBOutlet weak var singleImgView: UIImageView!
    
    @IBOutlet weak var multipleImgView1: UIImageView!
    
    @IBOutlet weak var multipleImgView2: UIImageView!
    
    @IBOutlet weak var multipleImgView3: UIImageView!
    
    @IBOutlet weak var multipleImgView4: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func singlePage(img: String) {
        
        singleImgView.alpha = 1.0
    
        singleImgView.kf.setImage(with: URL(string: img))
    }
    
    func multiplePages(imgs: [String]) {
        
        singleImgView.alpha = 0.0
        
        multipleImgView1.kf.setImage(with: URL(string: imgs[0]))
        
        multipleImgView2.kf.setImage(with: URL(string: imgs[1]))
        
        multipleImgView3.kf.setImage(with: URL(string: imgs[2]))
        
        multipleImgView4.kf.setImage(with: URL(string: imgs[3]))
    }
    
    func layout(title: String, description: String) {
        
        titleLbl.text = title
        
        descriptionLbl.text = description
    }
}
