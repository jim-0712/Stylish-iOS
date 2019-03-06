//
//  CheckoutViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class CheckoutViewController: STBaseViewController, UITableViewDataSource, UITableViewDelegate {

    enum CellType {
        
        case product(Int)
        
        case inputField
        
        case deliveryTime
        
        case detail
        
        func identifier() -> String {
            
            switch self {
                
            case .product: return String(describing: TrolleyTableViewCell.self)
                
            case .inputField: return String(describing: InputFieldCell.self)
                
            case .deliveryTime: return String(describing: SegmentedCell.self)
                
            case .detail: return String(describing: BillCell.self)
                
            }
        }
        
        func count() -> Int {
            
            switch self {
                
            case .product(let count): return count
                
            case .inputField: return 4
            
            case .deliveryTime: return 1
            
            case .detail: return 1
            
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
        
            tableView.delegate = self
            
            tableView.dataSource = self
        }
    }
    
    var orders: [LSOrder] = []
    
    var datas: [CellType] = [.product(0), .inputField, .deliveryTime, .detail] {
        
        didSet {
            
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func fetchData() {
        
        StorageManager.shared.fetchOrders(completion: { result in
            
            switch result{
                
            case .success(let orders):
                
                self.orders = orders
                
                datas = [.product(self.orders.count), .inputField, .deliveryTime, .detail]
                
            case .failure(_):
                
                LKProgressHUD.showFailure(text: "讀取資料失敗！")
            }
        })
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas[section].count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: datas[indexPath.section].identifier(), for: indexPath)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 67
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: String(describing: CheckoutHeaderCell.self)
        )
        
        guard let headerView = header as? CheckoutHeaderCell else { return header }
        
        return header
    }
    
}
