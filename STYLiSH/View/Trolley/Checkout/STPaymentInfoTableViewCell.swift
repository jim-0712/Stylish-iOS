//
//  STPaymentInfoTableViewCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/7/26.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

protocol STPaymentInfoTableViewCellDelegate: AnyObject {
    
    func didChangePaymentMethod(_ cell: STPaymentInfoTableViewCell, index: Int)
    
    func checkout(_ cell: STPaymentInfoTableViewCell)
    
    func textsForPickerView(_ cell: STPaymentInfoTableViewCell) -> [String]
    
    func heightForConstraint(_ cell: STPaymentInfoTableViewCell, at index: Int) -> CGFloat
    
    func isHidden(_ cell: STPaymentInfoTableViewCell, at index: Int) -> Bool
    
    func endEditing(_ cell: STPaymentInfoTableViewCell)
}

class STPaymentInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var paymentTextField: UITextField! {
        
        didSet {
        
            let shipPicker = UIPickerView()
            
            shipPicker.dataSource = self
            
            shipPicker.delegate = self
            
            paymentTextField.inputView = shipPicker
            
            let button = UIButton(type: .custom)
            
            button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            
            button.setBackgroundImage(
                UIImage.asset(.Icons_24px_DropDown),
                for: .normal
            )
            
            button.isUserInteractionEnabled = false
            
            paymentTextField.rightView = button
            
            paymentTextField.rightViewMode = .always
            
            paymentTextField.delegate = self
        }
    }
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    @IBOutlet weak var dueDateTextField: UITextField!
    
    @IBOutlet weak var verifyCodeTextField: UITextField!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var shipPriceLabel: UILabel!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var productAmountLabel: UILabel!
    
    @IBOutlet weak var topDistanceConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var appleView: UIView!
  
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//      super.init(style: style, reuseIdentifier: reuseIdentifier)
//      let percentBtn: UIButton = {
//        let hi = UIButton()
//        NSLayoutConstraint.activate([
//          hi.topAnchor.constraint(equalTo: appleView.topAnchor, constant: 0),
//          hi.bottomAnchor.constraint(equalTo: appleView.bottomAnchor, constant: 0),
//          hi.leadingAnchor.constraint(equalTo: appleView.leadingAnchor, constant: 50),
//          hi.widthAnchor.constraint(equalToConstant: 40)
//        ])
//        hi.translatesAutoresizingMaskIntoConstraints = false
//        hi.backgroundColor = .red
//        return hi
//      }()
//      appleView.addSubview(percentBtn)
//  }
//
//  required init?(coder: NSCoder) {
//    super.init(coder: coder)
//  }
  
  @IBOutlet weak var creditView: UIView! {
        
        didSet {
        
            creditView.isHidden = true
        }
    }
    
    @IBOutlet weak var checkoutBtn: UIButton!
    
    private lazy var paymentMethod: [String] = self.delegate?.textsForPickerView(self) ?? []
    
    weak var delegate: STPaymentInfoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func layoutCellWith(
        productPrice: Int,
        shipPrice: Int,
        productCount: Int,
        payment: String,
        isCheckoutEnable: Bool
    ) {
        
        productPriceLabel.text = "NT$ \(productPrice)"
        
        shipPriceLabel.text = "NT$ \(shipPrice)"
        
        totalPriceLabel.text = "NT$ \(shipPrice + productPrice)"
        
        productAmountLabel.text = "總計 (\(productCount)樣商品)"
    
        paymentTextField.text = payment
        
        updateCheckouttButton(isEnable: isCheckoutEnable)
    }
    
    func updateCheckouttButton(isEnable: Bool) {
        
        checkoutBtn.isEnabled = isEnable
        
        checkoutBtn.backgroundColor = isEnable ? UIColor.B1 : UIColor.B5
    }
    
    @IBAction func checkout() {
        
        delegate?.checkout(self)
    }
}

extension STPaymentInfoTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        return 2
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        
        return paymentMethod[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        paymentTextField.text = paymentMethod[row]
        
        guard
            let height = delegate?.heightForConstraint(self, at: row),
            let isHidden = delegate?.isHidden(self, at: row)
        else {
            return
        }
        
        topDistanceConstraint.constant = height
        
        creditView.isHidden = isHidden
        
        delegate?.didChangePaymentMethod(
            self,
            index: row
        )
    }
}

extension STPaymentInfoTableViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        delegate?.endEditing(self)
    }
}
