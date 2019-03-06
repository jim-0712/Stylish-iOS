//
//  ProductsListProvider.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/2.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

class ProductsProvider: ProductListDataProvider {
    
    private enum ProductType {
        
        case men
        
        case women
        
        case accessories
    }
    
    let productType: ProductType
    
    let dataProvider: MarketProvider
    
    init(productType: ProductType, dataProvider: MarketProvider) {
        
        self.productType = productType
        
        self.dataProvider = dataProvider
    }
    
    func fetchData(paging: Int, completion: @escaping ProductsResponseWithPaging) {
        
        switch productType {
            
        case .women: dataProvider.fetchProductForWomen(paging: paging, completion: completion)
            
        case .men: dataProvider.fetchProductForMen(paging: paging, completion: completion)
        
        case .accessories: dataProvider.fetchProductForAccessories(paging: paging, completion: completion)
        
        }
    }
}
