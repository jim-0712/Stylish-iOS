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

    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var descriptionLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func singlePage(img: String, title: String, description: String) {

        singleImgView.alpha = 1.0

        singleImgView.loadImage(img, placeHolder: UIImage.asset(.Image_Placeholder))

        titleLbl.text = title

        descriptionLbl.text = description
    }

    func multiplePages(imgs: [String], title: String, description: String) {

        singleImgView.alpha = 0.0

        multipleImgView1.loadImage(imgs[0], placeHolder: UIImage.asset(.Image_Placeholder))

        multipleImgView2.loadImage(imgs[1], placeHolder: UIImage.asset(.Image_Placeholder))

        multipleImgView3.loadImage(imgs[2], placeHolder: UIImage.asset(.Image_Placeholder))

        multipleImgView4.loadImage(imgs[3], placeHolder: UIImage.asset(.Image_Placeholder))

        titleLbl.text = title

        descriptionLbl.text = description
    }
}
