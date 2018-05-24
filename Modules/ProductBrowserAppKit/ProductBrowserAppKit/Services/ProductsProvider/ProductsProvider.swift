//
//  ProductsProvider.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result

protocol ProductsProvider {
    
    func queryProducts(completion: @escaping (ProductsQueryResult) -> Void)
}

typealias ProductsQueryResult = Result<[Product], AnyError>
