//
//  STNoUnderlineNavigationController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/15.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class STNoUnderlineNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = false

        navigationBar.setBackgroundImage(UIImage(), for: .default)

        navigationBar.shadowImage = UIImage()
    }

}
