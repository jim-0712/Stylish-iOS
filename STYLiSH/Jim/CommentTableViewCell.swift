//
//  CommentTableViewCell.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/7.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  @IBOutlet weak var starBtn: UIButton!

  @IBOutlet weak var starBtn2: UIButton!
  
  @IBOutlet weak var starBtn3: UIButton!
  
  @IBOutlet weak var starBtn4: UIButton!
  
  @IBOutlet weak var starBtn5: UIButton!
  
  @IBOutlet weak var userIdLabel: UILabel!
  
  @IBOutlet weak var commentTextView: UITextView!
  
  @IBOutlet weak var timeLabel: UILabel!
  override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }

}
