//
//  ProductRefresherImp.swift
//  ProductsApp
//
//  Created by Grigory Entin on 15/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import Result
import Dispatch

class ProductsRefresherImp : ProductsRefresher {
    
    // MARK: - <ProductRefresher>
    
    func clearRefreshing() {
    }
    
    func refreshProductsAsNecessary() {
        
        let date = Date()
        productsProvider.queryProducts() { [productsKeeper] (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    productsKeeper.lastError = error
                case .success(let products):
                    productsKeeper.lastUpdated = date
                    productsKeeper.lastError = nil
                    productsKeeper.products = products
                }
            }
        }
    }
    
    // MARK: -
    
    let productsProvider: ProductsProvider
    let productsKeeper: ProductsKeeper
    
    init(productsProvider: ProductsProvider, productsKeeper: ProductsKeeper) {
        self.productsProvider = productsProvider
        self.productsKeeper = productsKeeper
    }
    
    deinit {()}
}
