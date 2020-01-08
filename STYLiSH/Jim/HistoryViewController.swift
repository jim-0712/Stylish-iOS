//
//  HistoryViewController.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/3.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import UIKit
import Kingfisher
import JGProgressHUD

class HistoryViewController: UIViewController {

    var orderNumber = ""
    var productID = ""
    
    var total = 0
    var storeManJim = StoreJimS.sharedJim
    
    @IBOutlet weak var cartTable: UITableView!
    @IBAction func writeButton(_ sender: Any) {
        
        guard let vc = UIStoryboard(name: "Comment", bundle: nil).instantiateViewController(identifier: "Make Comment") as? MakeCommentViewController else {
            return
        }
        vc.orderNumber = orderNumber
        vc.productID = productID
        vc.navigationController?.pushViewController(vc, animated: true)
        show(vc, sender: nil)
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTable.delegate = self
        cartTable.dataSource = self
        cartTable.separatorStyle = .none
        
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = storeManJim.historyData.count
        if count == 0 {
            return 0
        } else {
            return storeManJim.historyData[0].orderlist.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if storeManJim.historyData.count == 0 {
            return UITableViewCell()
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "history", for: indexPath) as? HistoryTableViewCell else { return UITableViewCell() }
            
            cell.accountLabel.text = "數量：\(storeManJim.historyData[0].orderlist[indexPath.row].list[0].qty)"
            cell.numberLabel.text = "訂單編號\(storeManJim.historyData[0].orderlist[indexPath.row].number)"
            cell.productLabel.text = storeManJim.historyData[0].orderlist[indexPath.row].list[0].name
            cell.sizeLabel.text = storeManJim.historyData[0].orderlist[indexPath.row].list[0].size
            let colorUrl = storeManJim.historyData[0].orderlist[indexPath.row].list[0].color
            cell.colorBlock.backgroundColor = UIColor.hexStringToUIColor(hex: colorUrl)
            cell.moneyLabel.text = "價格：\(storeManJim.historyData[0].orderlist[indexPath.row].list[0].price)"
            let imageURL = URL(string: storeManJim.historyData[0].orderlist[indexPath.row].list[0].mainimage)
            cell.pictureView.kf.setImage(with: imageURL)
            
            orderNumber = storeManJim.historyData[0].orderlist[indexPath.row].number
            productID = storeManJim.historyData[0].orderlist[indexPath.row].list[0].id
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
