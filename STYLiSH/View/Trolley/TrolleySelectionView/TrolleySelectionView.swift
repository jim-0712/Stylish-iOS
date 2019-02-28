//
//  TrolleySelectionView.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/28.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class TrolleySelectionView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initView()
    }
    
    private func initView() {
        
        backgroundColor = UIColor.white
        
        Bundle.main.loadNibNamed(
            String(describing: TrolleySelectionView.self),
            owner: self,
            options: nil
        )
        
        stickSubView(contentView)
    }

}
