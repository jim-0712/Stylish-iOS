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

protocol Couponmanager: AnyObject {
  func couponUse(_ cell: STPaymentInfoTableViewCell,free: Bool, percent: Bool)
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
  

  @IBOutlet weak var freeShipBtn: UIButton!
  
  @IBOutlet weak var percentBtn: UIButton!
  
  @IBOutlet weak var useBtn: UIButton!
  
  var useFree = false
  var usePercent = false
  
  @IBAction func useAction(_ sender: Any) {
    
    self.delegateJim?.couponUse(self, free: useFree, percent: usePercent)
    useBtn.isEnabled = false
    
  }
  
  @IBAction func percentAction(_ sender: Any) {
    usePercent = !usePercent
    
    if usePercent{
      percentBtn.isEnabled = false
      freeShipBtn.isEnabled = true
    }else{
      percentBtn.isEnabled = true
      freeShipBtn.isEnabled = false
    }
  }
  
  
  @IBAction func freeBtnAct(_ sender: Any) {
    useFree = !useFree
    
    if useFree {
      percentBtn.isEnabled = true
      freeShipBtn.isEnabled = false
    }else {
      percentBtn.isEnabled = false
      freeShipBtn.isEnabled = true
    }
  }
  
  @IBAction func realToCheck(_ sender: Any) {
    
    NotificationCenter.default.post(name: Notification.Name("reloadTicket"), object: nil)
  }
  
  

  @IBOutlet weak var creditView: UIView! {
        
        didSet {
        
            creditView.isHidden = true
        }
    }
    
    @IBOutlet weak var checkoutBtn: UIButton!
    
    private lazy var paymentMethod: [String] = self.delegate?.textsForPickerView(self) ?? []
    
    weak var delegate: STPaymentInfoTableViewCellDelegate?
  
    weak var delegateJim: Couponmanager?
    
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
