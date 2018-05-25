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
    
    var refreshInProgress = false
    
    func refreshProductsAsNecessary() {
        
        guard !refreshInProgress else {
            return
        }
        
        let date = Date()
        refreshInProgress = true
        productsProvider.queryProducts() { [weak self, productsKeeper] (result) in
            DispatchQueue.main.async {
                defer { self?.refreshInProgress = false }
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
