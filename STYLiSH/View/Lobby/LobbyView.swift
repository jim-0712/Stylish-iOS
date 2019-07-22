//
//  LobbyView.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/7/22.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

protocol LobbyViewDelegate: UITableViewDataSource, UITableViewDelegate, AnyObject {
    
    func triggerRefresh(_ lobbyView: LobbyView)
}

class LobbyView: UIView {

    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            
            tableView.dataSource = self.delegate
            
            tableView.delegate = self.delegate
        }
    }
    
    weak var delegate: LobbyViewDelegate? {
        
        didSet {
            
            guard let tableView = tableView else { return }
            
            tableView.dataSource = self.delegate
            
            tableView.delegate = self.delegate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTableView()
    }
    //MARK: - Action
    
    func beginHeaderRefresh() {
        
        tableView.beginHeaderRefreshing()
    }
    
    func reloadData() {
        
        tableView.endHeaderRefreshing()
        
        tableView.reloadData()
    }
    
    //MARK: - Private Method
    
    private func setupTableView() {
        
        tableView.lk_registerCellWithNib(
            identifier: String(describing: LobbyTableViewCell.self),
            bundle: nil
        )
        
        tableView.register(
            LobbyTableViewHeaderView.self,
            forHeaderFooterViewReuseIdentifier: String(describing: LobbyTableViewHeaderView.self)
        )
        
        tableView.addRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.delegate?.triggerRefresh(strongSelf)
        })
    }
}
