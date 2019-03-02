//
//  HTTPClient.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

enum Result<T> {
    
    case success(T)
    
    case failure(Error)
}

enum STHTTPClientError: Error {
    
    case decodeDataFail
    
    case clientError(Data)
    
    case serverError
    
    case unexpectedError
}

protocol STRequest {
    
    var headers: [String: String] { get }
    
    var body: Data? { get }
    
    var method: String { get }
    
    var endPoint: String { get }
}

class HTTPClient {
    
    static let shared = HTTPClient()
    
    private let urlKey = "STBaseURL"
    
    private let decoder = JSONDecoder()
    
    private init() { }
    
    func request(
        _ stRequest: STRequest,
        completion: @escaping (Result<Data>) -> Void
    ) {
        
        URLSession.shared.dataTask(
            with: makeRequest(stRequest),
            completionHandler: { (data, response, error) in
                
            guard error == nil else {
                
                return completion(Result.failure(error!))
            }
            
            let httpResponse = response as! HTTPURLResponse
            
            let statusCode = httpResponse.statusCode
            
            switch statusCode {
                
            case 200..<300:
                
                completion(Result.success(data!))
            
            case 400..<500:
                
                completion(Result.failure(STHTTPClientError.clientError(data!)))
                
            case 500..<600:
                
                completion(Result.failure(STHTTPClientError.serverError))
            
            default: return
            
                completion(Result.failure(STHTTPClientError.unexpectedError))
            }
            
        }).resume()
    }
    
    private func makeRequest(_ stRequest: STRequest) -> URLRequest {
        
        let urlString = (Bundle.main.infoDictionary![urlKey] as! String) + stRequest.endPoint
        
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = stRequest.headers
        
        request.httpBody = stRequest.body
        
        request.httpMethod = stRequest.method
        
        return request
    }
}
