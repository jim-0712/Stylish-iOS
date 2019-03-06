//
//  ProductDetailViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/2.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class ProductDetailViewController: STBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    private struct Segue {
        
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
    
    @IBOutlet weak var addToCarBtn: UIButton!
    
    lazy var blurView: UIView = {
        
        let blurView = UIView(frame: tableView.frame)
        
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        return blurView
    }()
    
    private let datas: [ProductContentCategory] = [.description, .color, .size, .stock, .texture, .washing, .placeOfProduction, .remarks]
    
    var product: Product? {
        
        didSet {
            
            guard let product = product,
                  let galleryView = galleryView
            else { return }
            
            galleryView.datas = product.images
        }
    }
    
    var pickerViewController: ProductPickerController?
    
    override var isHideNavigationBar: Bool {
        
        return true
    }
    
    
    //MARK: - View Life Cycle
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.picker,
           let pickerVC = segue.destination as? ProductPickerController {
            
            pickerVC.delegate = self

            pickerVC.product = product
            
            pickerViewController = pickerVC
        }
    }
    
    //MARK: - Action
    @IBAction func didTouchAddToCarBtn(_ sender: UIButton) {
    
        if productPickerView.superview == nil {
            
            showProductPickerView()
        
        } else {
        
            guard let color = pickerViewController?.selectedColor,
                  let size = pickerViewController?.selectedSize,
                  let amount = pickerViewController?.selectedAmount,
                  let product = product
            else { return }
            
            StorageManager.shared.saveOrder(
                color: color, size: size, amount: amount, product: product,
                completion: { result in
                
                    switch result{
                        
                    case .success(_):
                        
                        LKProgressHUD.showSuccess()
                        
                        dismissPicker(pickerViewController!)
                        
                    case .failure(_):
                    
                        LKProgressHUD.showFailure(text: "儲存失敗！")
                    }
                })
        }
    }
    
    func showProductPickerView() {
        
        productPickerView.frame = CGRect(
            x: 0, y: UIScreen.height - 80.0, width: UIScreen.width, height: 0.0
        )
        
        view.insertSubview(productPickerView, belowSubview: addToCarBtn.superview!)
        
        view.insertSubview(blurView, belowSubview: productPickerView)
        
        UIView.animate(
            withDuration: 0.3,
            animations: { [weak self] in
                
                let y = 145.0 / 667.0 * UIScreen.height
                
                self?.productPickerView.frame = CGRect(
                    x: 0, y: y , width: UIScreen.width, height: UIScreen.height - y - 80.0
                )
                
                self?.isEnableAddToCarBtn(false)
            }
        )
    }
    
    func isEnableAddToCarBtn(_ flag: Bool) {
        
        if flag {
            
            addToCarBtn.isEnabled = true
        
            addToCarBtn.backgroundColor = UIColor.B1
        
        } else {
         
            addToCarBtn.isEnabled = false
        
            addToCarBtn.backgroundColor = UIColor.B4
        }
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
            
                self?.blurView.removeFromSuperview()
                
                self?.isEnableAddToCarBtn(true)
                
            }, completion: { [weak self] _ in
            
                self?.productPickerView.removeFromSuperview()
            }
        )
    }
    
    func valueChange(_ controller: ProductPickerController) {
        
        guard let _ = controller.selectedColor,
              let _ = controller.selectedSize,
              let _ = controller.selectedAmount
        else {
        
            isEnableAddToCarBtn(false)
            
            return
        }
        
        isEnableAddToCarBtn(true)
    }
}
