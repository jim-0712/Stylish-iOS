//
//  ProductDetailViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/2.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
        
            tableView.dataSource = self
            
            tableView.delegate = self
        }
    }
    
    @IBOutlet weak var galleryView: LKGalleryView! {
        
        didSet {
            galleryView.frame.size.height = UIScreen.width / 375.0 * 500.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }
    
    //MARK: - UITableViewDelegate

}

extension ProductDetailViewController: LKGalleryViewDelegate {
    
    func sizeForItem(_ galleryView: LKGalleryView) -> CGSize {
        
        return CGSize(width: UIScreen.width, height: UIScreen.width / 375.0 * 500.0)
    }
}
