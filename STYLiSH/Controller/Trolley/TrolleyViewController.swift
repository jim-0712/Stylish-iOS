//
//  TrolleyViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/28.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class TrolleyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: String(describing: TrolleyTableViewCell.self), bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: String(describing: TrolleyTableViewCell.self))
    }
    
}

extension TrolleyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TrolleyTableViewCell.self), for: indexPath)
        
        return cell
    }
}

extension TrolleyViewController: UITableViewDelegate {
    
}
