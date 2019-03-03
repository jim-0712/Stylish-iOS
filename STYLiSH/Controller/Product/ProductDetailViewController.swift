//
//  ProductDetailViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/2.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

private enum ProductCategory: String {
    
    case description = ""
    
    case color = "顏色"
    
    case size = "尺寸"
    
    case stock = "庫存"
    
    case texture = "材質"
    
    case washing = "洗滌"
    
    case placeOfProduction = "產地"
    
    case remarks = "備註"
    
    func identifier() -> String {
        
        switch self {
            
        case .description: return String(describing: ProductDescriptionTableViewCell.self)
            
        case .color: return ProductDetailCell.color
            
        case .size, .stock, .texture, .washing, .placeOfProduction, .remarks: return ProductDetailCell.label
            
        }
    }
    
    func cellForIndexPath(_ indexPath: IndexPath, tableView: UITableView, data: Product) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier(), for: indexPath)
        
        guard let basicCell = cell as? ProductBasicCell else { return cell }
        
        switch self {
        
        case .description:
            
            basicCell.layoutCell(product: data)
            
        case .color:

            basicCell.layoutCellWithColors(category: rawValue, colors: data.colors.map({ $0.code }))
            
        case .size:

            basicCell.layoutCell(category: rawValue, content: data.size)
        
        case .stock:
            
            basicCell.layoutCell(category: rawValue, content: String(data.stock))
            
        case .texture:
            
            basicCell.layoutCell(category: rawValue, content: data.texture)
            
        case .washing:
            
            basicCell.layoutCell(category: rawValue, content: data.wash)
            
        case .placeOfProduction:
            
            basicCell.layoutCell(category: rawValue, content: data.place)
            
        case .remarks:
            
            basicCell.layoutCell(category: rawValue, content: data.note)
        }
        
        return basicCell
    }
}

class ProductDetailViewController: STHideNavigationBarController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
        
            tableView.dataSource = self
            
            tableView.delegate = self
        }
    }
    
    @IBOutlet weak var galleryView: LKGalleryView! {
        
        didSet {
            
            galleryView.frame.size.height = UIScreen.width / 375.0 * 500.0
        
            galleryView.delegate = self
        }
    }
    
    private let datas: [ProductCategory] = [.description, .color, .size, .stock, .texture, .washing, .placeOfProduction, .remarks]
    
    var product: Product? {
        
        didSet {
            
            guard let product = product,
                  let galleryView = galleryView
            else { return }
            
            galleryView.datas = product.images
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        guard let product = product else { return }
        
        galleryView.datas = product.images
    }
    
    private func setupTableView() {
        
        tableView.lk_registerCellWithNib(identifier:
            String(describing: ProductDescriptionTableViewCell.self),
            bundle: nil
        )
        
        tableView.lk_registerCellWithNib(identifier:
            ProductDetailCell.color,
            bundle: nil
        )
        
        tableView.lk_registerCellWithNib(identifier:
            ProductDetailCell.label,
            bundle: nil
        )
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard product != nil else { return 0 }
        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let product = product else { return UITableViewCell() }
        
        return datas[indexPath.row].cellForIndexPath(indexPath, tableView: tableView, data: product)
    }
    
    //MARK: - UITableViewDelegate
    
}

extension ProductDetailViewController: LKGalleryViewDelegate {
    
    func sizeForItem(_ galleryView: LKGalleryView) -> CGSize {
        
        return CGSize(width: UIScreen.width, height: UIScreen.width / 375.0 * 500.0)
    }
}
