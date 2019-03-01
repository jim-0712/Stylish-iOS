//
//  STTapPayViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/1.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class STTapPayViewController: UIViewController {

    @IBOutlet weak var tapPayView: UIView!
    
    var tpdForm: TPDForm?
    
    var tpdCard: TPDCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let tapView = tapPayView else { return }

        tpdForm = TPDForm.setup(withContainer: tapView)
        
        tpdForm?.setErrorColor(UIColor.red)
        
        tpdForm?.setOkColor(UIColor.green)
        
        tpdForm?.setNormalColor(UIColor.black)
        
        tpdForm?.onFormUpdated { (status) in
            if (status.isCanGetPrime()) {
                // Can make payment.
            } else {
                // Can't make payment.
            }
        }
        
        tpdCard = TPDCard.setup(tpdForm!)
        
        tpdCard?.onSuccessCallback { (prime, cardInfo) in
            
            print("Prime : \(prime!), cardInfo : \(cardInfo)")
            
            }.onFailureCallback { (status, message) in
                
                print("status : \(status) , Message : \(message)")
                
            }.getPrime()
    }

}
