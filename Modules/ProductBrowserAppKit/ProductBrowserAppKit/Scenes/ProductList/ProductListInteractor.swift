//
//  ProductListInteractor.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxCocoa
import RxSwift
import Result
import Then

extension Array : Then {}

protocol ProductListInteractor {
    
    var observableProducts: Observable<[Product]> { get }
    
    func clearRefreshing()
    func refreshProductsAsNecessary()
}

class ProductListInteractorImp : ProductListInteractor {
    
    let productsKeeper: ProductsKeeper
    let productsProvider: ProductsProvider
    let productsRefresher: ProductsRefresher
    
    deinit {()}
    
    init(productsKeeper: ProductsKeeper, productsProvider: ProductsProvider, productsRefresher: ProductsRefresher) {
        
        self.productsKeeper = productsKeeper
        self.productsProvider = productsProvider
        self.productsRefresher = productsRefresher
    }
}

extension ProductListInteractorImp {
    
    // MARK: - <ProductListInteractor>
    
    var observableProducts: Observable<[Product]> {
        return productsKeeper.observableProducts
    }
    
    func clearRefreshing() {
        productsRefresher.clearRefreshing()
    }
    func refreshProductsAsNecessary() {
        productsRefresher.refreshProductsAsNecessary()
    }
}
