//
//  BillCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class BillCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var inputField: STBaseTextField!

    @IBOutlet weak var productPriceLbl: UILabel!

    @IBOutlet weak var freightLbl: UILabel!

    @IBOutlet weak var amountLbl: UILabel!

    @IBOutlet weak var totalPriceLbl: UILabel!

    var shipmentHandler: ((String) -> Void)?

    private lazy var pickerView: UIPickerView = {

        let picker = UIPickerView()

        picker.dataSource = self

        picker.delegate = self

        return picker
    }()

    let pickerOptions = ["貨到付款", "信用卡付款"]

    override func awakeFromNib() {
        super.awakeFromNib()

        inputField.inputView = pickerView
    }

    func layoutCell(amount: String, productPrice: Int, freightPrice: Int = 60) {

        amountLbl.text = "總計 ( \(amount) 樣商品)"

        productPriceLbl.text = "NT$ \(productPrice)"

        freightLbl.text = "NT$ \(freightPrice)"

        totalPriceLbl.text = "NT$ \(freightPrice + productPrice)"
    }

    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {

        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return pickerOptions.count
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return pickerOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        inputField.text = pickerOptions[row]

        shipmentHandler?(pickerOptions[row])
    }
}
