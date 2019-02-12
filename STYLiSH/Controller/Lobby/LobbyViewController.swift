//
//  LobbyViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            
            tableView.delegate = self
            
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    private func setupTableView() {
        
        let cellIdentifier = String(describing: LobbyTableViewCell.self)
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
}

extension LobbyViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: LobbyTableViewCell.self),
            for: indexPath
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "冬季新品搶先看"
    }
}

extension LobbyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 67.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 258.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        
        headerView.textLabel?.font = UIFont.medium(size: 18.0)
        
        headerView.textLabel?.textColor = UIColor.B1
        
        headerView.contentView.backgroundColor = UIColor.white
    }
}
