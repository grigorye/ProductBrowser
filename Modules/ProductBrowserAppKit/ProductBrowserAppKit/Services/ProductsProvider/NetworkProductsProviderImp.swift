//
//  NetworkProductsProviderImp.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result

struct NetworkProductsProviderImp : ProductsProvider {
    
    typealias Networking = ProductsNetworking
    
    var networking: Networking!
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func queryProducts(completion: @escaping (ProductsQueryResult) -> Void) {
        networking.queryProducts() { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(AnyError(error)))
                return
            case .success(let networkProducts):
                let products = networkProducts.map {
                    Product(
                        name: $0.name,
                        category: $0.category,
                        itemsRemaining: $0.items_remaining,
                        imageURL: URL(string: $0.image_url),
                        description: $0.description
                    )
                }
                completion(.success(products))
            }
        }
    }
}
