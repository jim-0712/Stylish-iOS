//
//  ProductViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/15.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var indicatorView: UIView!
    
    @IBOutlet weak var indicatorCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var layoutBtn: UIBarButtonItem!
    
    var isListLayout: Bool = true {
        
        didSet {
            switch isListLayout {
            
            case true: showListLayout()
                
            case false: showGridLayout()
            
            }
        }
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        isListLayout = true
    }

    //MARK: - Action
    @IBAction func onChangeProducts(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        moveIndicatorView(reference: sender)
    }
    
    @IBAction func onChangeLayoutType(_ sender: UIBarButtonItem) {

        isListLayout = !isListLayout
    }
    
    //MARK: - Private method
    private func showListLayout() {

        layoutBtn.image = UIImage.asset(.Icons_24px_ListView)
    }
    
    private func showGridLayout() {
        
        layoutBtn.image = UIImage.asset(.Icons_24px_CollectionView)
    }
    
    private func moveIndicatorView(reference: UIView) {
        
        indicatorCenterXConstraint.isActive = false
        
        indicatorCenterXConstraint = indicatorView.centerXAnchor.constraint(equalTo: reference.centerXAnchor)
        
        indicatorCenterXConstraint.isActive = true
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            
            self?.view.layoutIfNeeded()
        })
    }
}
