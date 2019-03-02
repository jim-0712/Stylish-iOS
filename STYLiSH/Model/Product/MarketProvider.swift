//
//  MarketProvider.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

typealias PromotionHanlder = (Result<[PromotedProducts]>) -> Void

typealias ProductsResponseWithPaging = (Result<STSuccessParser<[Product]>>) -> Void

class MarketProvider {
    
    let decoder = JSONDecoder()
    
    enum ProductType {
        
        case men
        
        case women
        
        case accessories
    }
    
    //MARK: - Public method
    func fetchHots(completion: @escaping PromotionHanlder) {
        
        HTTPClient.shared.request(
            STMarketRequest.hots,
            completion: { [weak self] result in
            
                guard let strongSelf = self else { return }
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        let products = try strongSelf.decoder.decode(STSuccessParser<[PromotedProducts]>.self, from: data)
                        
                        DispatchQueue.main.async {
                            
                           completion(Result.success(products.data))
                        }
                        
                    } catch {
                        
                        print(error)
                    }
                    
                case .failure(let error):
                    
                    print(error)
                }
        })
    }
    
    func fetchProductForMen(paging: Int, completion: @escaping ProductsResponseWithPaging) {
        
        fetchProducts(paging: paging, type: .men, completion: completion)
    }

    func fetchProductForWomen(paging: Int, completion: @escaping ProductsResponseWithPaging) {
        
        fetchProducts(paging: paging, type: .women, completion: completion)
    }
    
    func fetchProductForAccessories(paging: Int, completion: @escaping ProductsResponseWithPaging) {
        
        fetchProducts(paging: paging, type: .accessories, completion: completion)
    }
    
    //MARK: - Private method
    private func fetchProducts(paging: Int, type: MarketProvider.ProductType, completion: @escaping ProductsResponseWithPaging) {
        
        let requset: STMarketRequest
        
        switch type {
            
        case .women: requset = STMarketRequest.women(paging: paging)
            
        case .men: requset = STMarketRequest.men(paging: paging)
        
        case .accessories: requset = STMarketRequest.accessories(paging: paging)
        
        }
        
        HTTPClient.shared.request(
            requset,
            completion: { [weak self] result in
                
                guard let strongSelf = self else { return }
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        let response = try strongSelf.decoder.decode(STSuccessParser<[Product]>.self, from: data)
                        
                        DispatchQueue.main.async {
                            
                            completion(Result.success(response))
                        }
                        
                    } catch {
                        
                        print(error)
                    }
                    
                case .failure(let error):
                    
                    print(error)
                }
        })
    }
}
