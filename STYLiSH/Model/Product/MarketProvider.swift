//
//  MarketProvider.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

typealias PromotionHanlder = (Result<[PromotedProducts]>) -> Void

class MarketProvider {
    
    let decoder = JSONDecoder()
    
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
}
