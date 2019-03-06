//
//  CheckoutViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit
import FBSDKLoginKit

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
    
    private struct Segue {
        
        static let tapPay = "SegueTapPay"
        
        static let success = "SegueSuccess"
    }
    
    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
        
            tableView.delegate = self
            
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var footerView: UIView!
    
    var orders: [LSOrder] = []
    
    var datas: [CellType] = [.product(0), .inputField, .deliveryTime, .detail] {
        
        didSet {
            
            tableView.reloadData()
        }
    }
    
    let userProvider = UserProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    func setupTableView() {
        
        footerView.frame.size.height = 80.0
        
        tableView.tableFooterView = footerView
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
    
    @IBAction func checkout(_ sender: UIButton) {
        
        guard KeyChainManager.shared.token != nil else {
            
            onFacebookLogin()
            
            return
        }
        
        performSegue(withIdentifier: Segue.tapPay, sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.tapPay,
           let vc = segue.destination as? STTapPayViewController {
            
            vc.delegate = self
        }
        
    }
    
    func onFacebookLogin() {
        
        userProvider.loginWithFaceBook(from: self, completion: { [weak self] result in
            
            switch result{
            
            case .success(let token):
                
                self?.onSTYLiSHSignIn(token: token)
                
            case .failure(_):
                
                LKProgressHUD.showSuccess(text: "Facebook 登入失敗!")
            }
        })
    }
    
    func onSTYLiSHSignIn(token: String) {
        
        LKProgressHUD.show()
        
        userProvider.signInToSTYLiSH(fbToken: token, completion: { result in
            
            LKProgressHUD.dismiss()
            
            switch result{
                
            case .success(_):
                
                LKProgressHUD.showSuccess(text: "STYLiSH 登入成功")
                
            case .failure(_):
                
                LKProgressHUD.showSuccess(text: "STYLiSH 登入失敗!")
            }
            
        })
    }
    
    func checkout(prime: String) {
        
        LKProgressHUD.show()
        
        userProvider.checkout(prime: prime, completion: { [weak self] result in
        
            LKProgressHUD.dismiss()
            
            switch result{
                
            case .success(_):
                
                self?.performSegue(withIdentifier: Segue.success, sender: nil)
                
            case .failure(_):
                
                LKProgressHUD.showFailure(text: "結帳失敗！")
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
        
        let header = tableView.dequeueReusableCell(withIdentifier: String(describing: CheckoutHeaderCell.self))
        
        guard let headerView = header as? CheckoutHeaderCell else { return header }
        
        return headerView
    }
    
}

extension CheckoutViewController: STTapPayDelegate {
    
    func didCompelte(_ vc: STTapPayViewController, prime: String?) {
        
        guard let prime = prime else {
            
            LKProgressHUD.showFailure(text: "付款失敗！")
        
            DispatchQueue.main.async { [weak self] in
                
                guard let strongSelf = self else { return }
                
                self?.navigationController?.popToViewController(strongSelf, animated: true)
            }
            
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            
            guard let strongSelf = self else { return }
            
            self?.navigationController?.popToViewController(strongSelf, animated: true)
            
            self?.checkout(prime: prime)
        }
    }
}
