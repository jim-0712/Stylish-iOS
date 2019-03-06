//
//  TrolleyViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/28.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class TrolleyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var orders: [LSOrder] = [] {
        
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.lk_registerCellWithNib(identifier: String(describing: TrolleyTableViewCell.self), bundle: nil)
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    func fetchData() {
        
        StorageManager.shared.fetchOrders(completion: { result in
            
            switch result{
                
            case .success(let orders):
                
                self.orders = orders
                
            case .failure(_):
                
                LKProgressHUD.showFailure(text: "讀取資料發生錯誤！")
            }
        })
    }
    
    func deleteData(at index : Int) {
        
        StorageManager.shared.deleteOrder(
            orders[index],
            completion: { result in
                
                switch result{
                    
                case .success(_):
                    
                    LKProgressHUD.showSuccess()
                    
                    orders.remove(at: index)
                    
                case .failure(_):
                    
                    LKProgressHUD.showFailure(text: "刪除資料失敗！")
                }
        })
    }
}

extension TrolleyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TrolleyTableViewCell.self),
            for: indexPath
        )
        
        guard let trolleyCell = cell as? TrolleyTableViewCell else { return cell }
        
        trolleyCell.layoutView(order: orders[indexPath.row])
        
        trolleyCell.touchHandler = { [weak self] in
            
            self?.deleteData(at: indexPath.row)
        }
        
        trolleyCell.valueChangeHandler = { [weak self] value in
            
            self?.orders[indexPath.row].amount = value.int64()
            
            print("----Yo------")
            
            print(self?.orders[indexPath.row].amount)
        }
        
        return trolleyCell
    }
}

extension TrolleyViewController: UITableViewDelegate {
    
}
