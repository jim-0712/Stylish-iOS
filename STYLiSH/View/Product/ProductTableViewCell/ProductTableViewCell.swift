//
//  ProductTableViewCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/15.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
  
  @IBOutlet weak var productImg: UIImageView!
  
  @IBOutlet weak var productTitleLbl: UILabel!
  
  @IBOutlet weak var productPriceLbl: UILabel!
  
  @IBOutlet weak var commentAction: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  @IBAction func commentActionReal(_ sender: Any) {
    guard let vc = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(identifier: "Comment") as? CommentViewController else {
      return
    }
    vc.navigationController?.pushViewController(vc, animated: true)
//    self.show(vc, sender: nil)
  }
  
  func layoutCell(image: String, title: String, price: Int) {
    
    productImg.loadImage(image, placeHolder: UIImage.asset(.Image_Placeholder))
    
    productTitleLbl.text = title
    
    productPriceLbl.text = String(price)
  }
}

