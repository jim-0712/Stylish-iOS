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
    
    weak var delegate: ProductPickerControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onDismiss(_ sender: UIButton) {
        
        delegate?.dismissPicker(self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "\(indexPath.section) \(indexPath.row)"
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50.0
    }
}
