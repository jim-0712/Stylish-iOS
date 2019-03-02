//
//  STCompondViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/2.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class STCompondViewController:
    UIViewController,
    UITableViewDataSource,
    UITableViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegate
{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var datas: [[Any]] = [[]] {
        
        didSet {
            reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cpdSetupTableView()
        
        cpdSetupCollectionView()
        
        tableView.beginHeaderRefreshing()
    }
    
    private func cpdSetupTableView() {
        
        if tableView == nil {
            
            let tableView = UITableView()
            
            view.stickSubView(tableView)
            
            self.tableView = tableView
        }
        
        tableView.dataSource = self

        tableView.delegate = self
        
        tableView.addRefreshHeader(refreshingBlock: { [weak self] in
            
            self?.tableViewHeaderLoader()
        })
        
        tableView.addRefreshFooter(refreshingBlock: { [weak self] in
            
            self?.tableViewFooterLoader()
        })
    }

    private func cpdSetupCollectionView() {
        
        if collectionView == nil {
            
            let collectionView = UICollectionView(
                frame: CGRect.zero,
                collectionViewLayout: UICollectionViewFlowLayout()
            )
            
            view.stickSubView(collectionView)
            
            self.collectionView = collectionView
        }
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        collectionView.addRefreshHeader(refreshingBlock: { [weak self] in
            
            self?.collectionViewHeaderLoader()
        })
        
        collectionView.addRefreshFooter(refreshingBlock: { [weak self] in
            
            self?.collectionViewFooterLoader()
        })
    }
    
    func reloadData() {
        
        guard Thread.isMainThread == true else {
            
            DispatchQueue.main.async { [weak self] in
                
                self?.reloadData()
            }
            
            return
        }
        
        tableView.reloadData()
        
        collectionView.reloadData()
    }
    
    func tableViewHeaderLoader() {
        
        tableView.endHeaderRefreshing()
    }
    
    func tableViewFooterLoader() {
        
        tableView.endFooterRefreshing()
    }
    
    func collectionViewHeaderLoader() {
        
        collectionView.endHeaderRefreshing()
    }
    
    func collectionViewFooterLoader() {
        
        collectionView.endFooterRefreshing()
    }
    
    //MARK - UITableViewDataSource. Subclass should override these method for setting properly.
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell(style: .default, reuseIdentifier: String(describing: STCompondViewController.self))
    }
    
    //MARK - UICollectionViewDataSource. Subclass should override these method for setting properly.
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return datas[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
}
