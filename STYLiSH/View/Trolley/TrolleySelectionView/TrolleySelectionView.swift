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
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var substractBtn: UIButton!
    
    @IBOutlet weak var inputField: UITextField!
    
    private var inputViews: [UIView] {
        
        return [addBtn, substractBtn, inputField]
    }
    
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

    func isEnable(_ flag: Bool) {
        
        if flag {
            
            inputViews.forEach({ item in
                
                item.layer.borderColor = UIColor.B1?.cgColor
                
                item.tintColor = UIColor.B1
            })
            
            addBtn.isEnabled = true
            
            substractBtn.isEnabled = true
            
            inputField.isEnabled = true
            
        } else {
            
            inputViews.forEach({ item in
                
                item.layer.borderColor = UIColor.B1?.withAlphaComponent(0.4).cgColor
                
                item.tintColor = UIColor.B1?.withAlphaComponent(0.4)
            })
            
            addBtn.isEnabled = false
            
            substractBtn.isEnabled = false
            
            inputField.isEnabled = false
        }
    }
    
}
