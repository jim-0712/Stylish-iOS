//
//  STTapPayViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/1.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit
import TPDirect

class STTapPayViewController: STBaseViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var cardView: UIView!

    var cardStatusHandler: ((Bool) -> Void)?
    
    var tpdCard: TPDCard!
    
    var tpdForm: TPDForm!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. Setup TPDForm With Your Customized CardView, Recommend(width:260, height:80)
        tpdForm = TPDForm.setup(withContainer: cardView)

        // 2. Setup TPDForm Text Color
        tpdForm.setErrorColor(UIColor.red)
        tpdForm.setOkColor(UIColor.blue)
        tpdForm.setNormalColor(UIColor.black)

        // 3. Setup TPDForm onFormUpdated Callback
        tpdForm.onFormUpdated { [weak self] status in

            // Use callback Get Status.
            
            self?.cardStatusHandler?(status.isCanGetPrime())
        }

    }

    // MARK: - @IBAction
    func getPrime(completion: @escaping (Result<String>) -> Void) {

        // Example Card
        // Number : 4242 4242 4242 4242
        // DueMonth : 01
        // DueYear : 23
        // CCV : 123

        // 1. Setup TPDCard.
        tpdCard = TPDCard.setup(tpdForm)

        // 2. Setup TPDCard on Success Callback

        tpdCard
            .onSuccessCallback { (prime, _) in

                guard let prime = prime else { return }
                
                completion(Result.success(prime))

            }.onFailureCallback { (_, message) in

                // Error Handle
                print(message)
            }
            .getPrime()
    }
}
