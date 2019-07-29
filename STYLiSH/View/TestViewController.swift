//
//  TestViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/7/26.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let header = ["結帳商品", "收件資訊", "付款詳情"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        
        tableView.delegate = self
        
        tableView.lk_registerCellWithNib(identifier: String(describing: STOrderProductCell.self), bundle: nil)
        
        tableView.lk_registerCellWithNib(identifier: String(describing: STOrderUserInputCell.self), bundle: nil)
        
        tableView.lk_registerCellWithNib(identifier: String(describing: STPaymentInfoTableViewCell.self), bundle: nil)
        
        let headerXib = UINib(nibName: String(describing: STOrderHeaderView.self), bundle: nil)
        
        tableView.register(headerXib, forHeaderFooterViewReuseIdentifier: String(describing: STOrderHeaderView.self))
    }

}

extension TestViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 67.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: STOrderHeaderView.self)) as? STOrderHeaderView else {
            return nil
        }
        
        headerView.titleLabel.text = header[section]
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return " "
    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//
//        return UIView()
//    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        guard let footerView = view as? UITableViewHeaderFooterView else { return }
        
        footerView.contentView.backgroundColor = UIColor.hexStringToUIColor(hex: "cccccc")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return header.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if indexPath.section == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: STOrderProductCell.self), for: indexPath)
            
        } else if indexPath.section == 1 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: STOrderUserInputCell.self), for: indexPath)
            
        } else {
            
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: STPaymentInfoTableViewCell.self), for: indexPath)
            
//            guard let paymentCell = cell as? STPaymentInfoTableViewCell else {
            
//                return cell
//            }
            
//            paymentCell.delegate = self
        }
        
        return cell
    }
}
