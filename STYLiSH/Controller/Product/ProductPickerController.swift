//
//  ProductPickerController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/4.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

protocol ProductPickerControllerDelegate: AnyObject {
    
    func dismissPicker(_ controller: ProductPickerController)
}

class ProductPickerController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            
            tableView.dataSource = self
            
            tableView.delegate = self
        }
    }
    
    @IBOutlet weak var headerView: UIView!
    
    weak var delegate: ProductPickerControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            SizeSelectionCell.self,
            forCellReuseIdentifier: String(describing: SizeSelectionCell.self)
        )
    
        tableView.register(
            ColorSelectionCell.self,
            forCellReuseIdentifier: String(describing: ColorSelectionCell.self)
        )
    }
    
    @IBAction func onDismiss(_ sender: UIButton) {
        
        delegate?.dismissPicker(self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SizeSelectionCell.self), for: indexPath)
            
            return cell
    
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ColorSelectionCell.self), for: indexPath)
            
            guard let colorCell = cell as? ColorSelectionCell else { return cell }
            
            colorCell.colors = ["FFFFFF", "DDFFBB", "CCCCCC"]
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 108.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerView
    }
}
