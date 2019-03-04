//
//  SizeSelectionCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/5.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

enum SizeType: String, CaseIterable {
    
    case XS
    
    case S
    
    case M
    
    case L
}

enum StockStatus {

    case avaliable
    
    case unAvaliable
    
    case selected
}

struct SizeObject {
    
    let size: SizeType
    
    var status: StockStatus = .avaliable
}

class SizeSelectionCell: BasicSelectionCell {

    lazy var sizes: [SizeObject] = {
        
        var result: [SizeObject] = []
        
        for type in SizeType.allCases {
            
            let object = SizeObject(size: type, status: .avaliable)
    
            result.append(object)
        }
        
        return result
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLetterSpacing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupLetterSpacing()
    }
    
    private func setupLetterSpacing() {
        
        titleLbl.text = "選擇尺寸"
        
        titleLbl.characterSpacing = 2.1
    }
    
    override func numberOfItem(_ cell: BasicSelectionCell) -> Int {
        
        return sizes.count
    }
    
    override func viewIn(_ cell: BasicSelectionCell, selectionCell: SelectionCell, indexPath: IndexPath) {
        
        guard let sizeView = selectionCell.objectView as? SizeView else {
            
            let sizeView = SizeView()
            
            sizeView.layoutCell(with: sizes[indexPath.row])
        
            selectionCell.objectView = sizeView
            
            return
        }
        
        sizeView.layoutCell(with: sizes[indexPath.row])
    }
    
    override func didSelected(_ cell: BasicSelectionCell, at indexPath: IndexPath) {
        
        for index in 0 ..< sizes.count {
        
            if sizes[index].status == .selected {
                
                sizes[index].status = .avaliable
            }
        }
        
        sizes[indexPath.row].status = .selected
        
        collectionView.reloadData()
    }
}

private class SizeView: UIView {
    
    lazy var sizeLbl: UILabel = {
        
        let label = UILabel()
        
        stickSubView(label, inset: UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0))
        
        label.textAlignment = .center
        
        label.backgroundColor = UIColor.B5
        
        return label
    }()
    
    lazy var slashImg: UIImageView = {
        
        let imageView = UIImageView()
        
        stickSubView(imageView)
        
        imageView.image = UIImage.asset(.Image_StrikeThrough)
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.backgroundColor = UIColor.clear
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initView()
    }
    
    func initView() {
        
        sizeLbl.textColor = UIColor.B1
        
        slashImg.isHidden = true
        
        layer.borderWidth = 1
    }
    
    func layoutCell(with object: SizeObject) {
        
        sizeLbl.text = object.size.rawValue
        
        layer.borderColor = UIColor.B5?.cgColor
        
        backgroundColor = UIColor.B5
        
        switch object.status {
            
        case .avaliable: slashImg.isHidden = true
            
        case .unAvaliable: slashImg.isHidden = false
            
        case .selected:
            
            layer.borderColor = UIColor.B1?.cgColor
            
            backgroundColor = UIColor.white
        }
    }
}
