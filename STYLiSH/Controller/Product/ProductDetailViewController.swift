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

class ProductDetailViewController: STBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct Segue {
        
        static let picker = "SeguePicker"
    }
    
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
    
    @IBOutlet weak var productPickerView: UIView!
    
    lazy var blurView: UIView = {
        
        let blurView = UIView(frame: tableView.frame)
        
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        return blurView
    }()
    
    private let datas: [ProductCategory] = [.description, .color, .size, .stock, .texture, .washing, .placeOfProduction, .remarks]
    
    var product: Product? {
        
        didSet {
            
            guard let product = product,
                  let galleryView = galleryView
            else { return }
            
            galleryView.datas = product.images
        }
    }
    
    override var isHideNavigationBar: Bool {
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        guard let product = product else { return }
        
        galleryView.datas = product.images
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.picker,
           let pickerVC = segue.destination as? ProductPickerController {
            
            pickerVC.delegate = self

            pickerVC.product = product
        }
    }
    
    @IBAction func onShowShoppingPage(_ sender: UIButton) {
    
        productPickerView.frame = CGRect(
            x: 0, y: UIScreen.height - 80.0, width: UIScreen.width, height: 0.0
        )
        
        view.insertSubview(productPickerView, belowSubview: sender.superview!)
        
        view.insertSubview(blurView, belowSubview: productPickerView)
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            
            let y = 145.0 / 667.0 * UIScreen.height
            
            self?.productPickerView.frame = CGRect(
                x: 0, y: y , width: UIScreen.width, height: UIScreen.height - y - 80.0
            )
        })
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

extension ProductDetailViewController: ProductPickerControllerDelegate {
    
    func dismissPicker(_ controller: ProductPickerController) {
        
        let origin = productPickerView.frame
        
        let nextFrame = CGRect(x: origin.minX, y: origin.maxY, width: origin.width, height: origin.height)
        
        UIView.animate(
            withDuration: 0.3,
            animations: { [weak self] in
            
                self?.productPickerView.frame = nextFrame
            
            }, completion: { [weak self] _ in
                
                self?.blurView.removeFromSuperview()
            
                self?.productPickerView.removeFromSuperview()
            }
        )
        
        
    }
}
