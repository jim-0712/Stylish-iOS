//
//  STTapPayViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/1.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit
import TPDirect

protocol STTapPayDelegate: AnyObject {
    
    func didCompelte(_ vc: STTapPayViewController, prime: String?)
}

class STTapPayViewController: STBaseViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var payButton: UIButton!
    
    weak var delegate: STTapPayDelegate?
    
    var tpdCard : TPDCard!
    var tpdForm : TPDForm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Setup TPDForm With Your Customized CardView, Recommend(width:260, height:80)
        tpdForm = TPDForm.setup(withContainer: cardView)
        
        // 2. Setup TPDForm Text Color
        tpdForm.setErrorColor(UIColor.red)
        tpdForm.setOkColor(UIColor.blue)
        tpdForm.setNormalColor(UIColor.black)
        
        
        
        // 3. Setup TPDForm onFormUpdated Callback
        tpdForm.onFormUpdated { (status) in
            
            // Use callback Get Status.
            
            weak var weakSelf = self
            
            weakSelf?.payButton.isEnabled = status.isCanGetPrime()
            weakSelf?.payButton.alpha     = (status.isCanGetPrime()) ? 1.0 : 0.25
            
        }
        
        // Button Disable (Default)
        payButton.isEnabled = false
        payButton.alpha     = 0.25
        
    }
    
    //MARK: - @IBAction
    @IBAction func doneAction(_ sender: Any) {
        
        // Example Card
        // Number : 4242 4242 4242 4242
        // DueMonth : 01
        // DueYear : 23
        // CCV : 123
        
        // 1. Setup TPDCard.
        tpdCard = TPDCard.setup(tpdForm)
        
        // 2. Setup TPDCard on Success Callback.
        tpdCard
            .onSuccessCallback { [weak self] (prime, cardInfo) in
            
                guard let strongSelf = self else { return }
                
                self?.delegate?.didCompelte(strongSelf, prime: prime)
            
            }.onFailureCallback { [weak self] (status, message) in
                
                guard let strongSelf = self else { return }
                
                self?.delegate?.didCompelte(strongSelf, prime: nil)
                
            }.getPrime()
    }
}
