//
//  ProductSelectionCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/4.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

protocol SelectionCellDataSource: AnyObject {
    
    func numberOfItem(_ cell: ProductSelectionCell) -> Int
    
    func viewIn(_ cell: ProductSelectionCell, indexPath: IndexPath) -> UIView
    
    func didSelected(_ cell: ProductSelectionCell, at indexPath: IndexPath)
}

class ProductSelectionCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            
            collectionView.dataSource = self
            
            collectionView.delegate = self
        }
    }
    
    @IBOutlet weak var titleLbl: UILabel!
        
    weak var dataSource: SelectionCellDataSource?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(
            SelectionCell.self,
            forCellWithReuseIdentifier: String(describing: SelectionCell.self)
        )
    }
 
    func reloadData() {
        
        collectionView.reloadData()
    }
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataSource?.numberOfItem(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SelectionCell.self), for: indexPath)
        
        guard let selectionCell = cell as? SelectionCell else { return cell }
        
        selectionCell.objectView = dataSource?.viewIn(self, indexPath: indexPath)
        
        return selectionCell
    }
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dataSource?.didSelected(self, at: indexPath)
    }
}

private class SelectionCell: UICollectionViewCell {
    
    var objectView: UIView! {
        
        didSet {
            stickSubView(objectView)
        }
    }
    
}
