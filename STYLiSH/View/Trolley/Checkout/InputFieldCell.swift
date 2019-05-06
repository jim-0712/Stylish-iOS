//
//  InputFieldCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class InputFieldCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var inputField: STBaseTextField! {

        didSet {
            inputField.delegate = self
        }
    }

    var textChangeHandler: ((String) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let text = textField.text, let range = Range(range, in: text) {
           let newText = text.replacingCharacters(in: range, with: string)

            textChangeHandler?(newText)
        }

        return true
    }
}
