//
//  OrderProvider.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

class OrderProvider {
    
    private enum CellType {
        
        case product(Int)
        
        case inputField
        
        case deliveryTime
        
        case detail
        
        func title() -> String {
            
            switch self {
                
            case .product: return "結帳商品"
                
            case .inputField: return "收件資訊"
                
            case .deliveryTime: return "配送時間"
                
            case .detail: return "付款詳情"
                
            }
        }
    }
    
    private enum RecieverColumn: String {
    
        case name = "收件人姓名"
        
        case email = "Email"
        
        case phoneNumber = "手機號碼"
        
        case address = "地址"
    }
    
    
    init() {
        
        fetchData()
    }
    
    func numberOfSection() -> Int {
        
        return datas.count
    }
    
    func numberOfRow(in section: Int) -> Int {
        
        return count(type: datas[section])
    }
    
    func titleForSection(_ section: Int) -> String {
    
        return datas[section].title()
    }
    
    func identifier(indexPath: IndexPath) -> String {
        
        return identifier(type: datas[indexPath.section])
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
    
    func manipulateCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        
        switch datas[indexPath.section] {
        
        case .product:
            
            guard let productCell = cell as? TrolleyTableViewCell else { return }
            
            productCell.layoutView(order: orders[indexPath.row])
            
        case .inputField:
            
            guard let inputCell = cell as? InputFieldCell else { return }
            
            switch recievers[indexPath.row] {
            
            case .name: inputCell.inputField.text = reciever.name ?? RecieverColumn.name.rawValue
                
            case .email: inputCell.inputField.text = reciever.email ?? RecieverColumn.email.rawValue
            
            case .phoneNumber: inputCell.inputField.text = reciever.phoneNumber ?? RecieverColumn.phoneNumber.rawValue
            
            case .address: inputCell.inputField.text = reciever.address ?? RecieverColumn.address.rawValue
            
            }
        
        case .deliveryTime:
        
            guard let segmentedCell = cell as? SegmentedCell else { return }
        
        case .detail:
        
            guard let inputCell = cell as? BillCell else { return }
        }
    }
    
    private var orders: [LSOrder] = []
    
    private var datas: [CellType] = [.product(0), .inputField, .deliveryTime, .detail]
    
    private let recievers: [RecieverColumn] = [.name, .email, .phoneNumber, .address]
    
    private var reciever: Reciever = Reciever()
    
    private func identifier(type: CellType) -> String {
        
        switch type {
            
        case .product: return String(describing: TrolleyTableViewCell.self)
            
        case .inputField: return String(describing: InputFieldCell.self)
            
        case .deliveryTime: return String(describing: SegmentedCell.self)
            
        case .detail: return String(describing: BillCell.self)
            
        }
    }
    
    private func count(type: CellType) -> Int {
        
        switch type {
            
        case .product(let count): return count
            
        case .inputField: return recievers.count
            
        case .deliveryTime: return 1
            
        case .detail: return 1
            
        }
    }
}
