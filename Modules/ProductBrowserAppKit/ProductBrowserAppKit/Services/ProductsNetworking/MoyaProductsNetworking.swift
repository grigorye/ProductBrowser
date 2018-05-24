//
//  MoyaNetworking.swift
//  OpenProductsMapKit/NetworkingImp/Moya
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Moya
import Result

struct MoyaProductsNetworkingImp : ProductsNetworking {
    
    typealias MoyaProvider = Moya.MoyaProvider<ProductsMoyaTarget>
    
    let moyaProvider: MoyaProvider
    
    static func defaultMoyaProvider() -> MoyaProvider {
        let plugins: [Moya.PluginType] = [
            NetworkLoggerPlugin(verbose: true, cURL: true)
        ]
        return MoyaProvider(plugins: plugins)
    }
    
    init(moyaProvider: MoyaProvider = defaultMoyaProvider()) {
        self.moyaProvider = moyaProvider
    }
    
    private func proceedWithRequestProductsResponse(_ response: Moya.Response) throws -> ProductsNetworkingResponse {
        do {
            let response = try response.filter(statusCode: 200)
            return try response.map(ProductsNetworkingResponse.self)
        } catch {
            throw AnyError(error)
        }
    }
    
    func queryProducts(completion: @escaping (ProductsNetworkingQueryResult) -> Void) {
        moyaProvider.request(.products) { (moyaResult) in
            switch moyaResult {
            case .failure(let error):
                completion(.failure(AnyError(error)))
                return
            case .success(let response):
                let result = ProductsNetworkingQueryResult() {
                    return try self.proceedWithRequestProductsResponse(response)
                }
                completion(result)
            }
        }
    }
}
