//
//  LobbyViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit
import MJRefresh

class LobbyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            
            tableView.delegate = self
            
            tableView.dataSource = self
        }
    }
    
    var datas: [PromotedProducts] = [] {
        
        didSet {
            
            tableView.reloadData()
        }
    }
    
    let marketProvider = MarketProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        
        tableView.mj_header.beginRefreshing()
    }
    
    private func setupLayout() {
        
        navigationItem.titleView = UIImageView(image: UIImage.asset(.Image_Logo02))
        
        navigationController?.navigationBar.barTintColor = UIColor.white.withAlphaComponent(0.9)
    
        setupTableView()
    }
    
    private func setupTableView() {
        
        let cellIdentifier = String(describing: LobbyTableViewCell.self)
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            
            self?.fetchData(completion: {
                
                self?.tableView.mj_header.endRefreshing()
            })
        })
    }
    
    func fetchData(completion: @escaping () -> Void) {
        
        marketProvider.fetchHots(completion: { [weak self] result in
            
            guard let strongSelf = self else { return }
            
            completion()
            
            switch result {
                
            case .success(let products):
                
                strongSelf.datas = products
                
            case .failure(let error):
            
                print(error)
            }
            
        })
    }
}

extension LobbyViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas[section].products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: LobbyTableViewCell.self),
            for: indexPath
        )
        
        guard let lobbyCell = cell as? LobbyTableViewCell else { return cell }
        
        let product = datas[indexPath.section].products[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            
            lobbyCell.singlePage(img: product.main_image)
        
        } else {
        
            lobbyCell.multiplePages(imgs: product.images)
        }
        
        lobbyCell.layout(
            title: product.title,
            description: product.description
        )
        
        return lobbyCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return datas[section].title
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
