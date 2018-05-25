//
//  ProductListHeaderInteractor.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 24/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift

protocol ProductListHeaderInteractor {
    
    var lastUpdatedObservable: Observable<Date?> { get }
    var productsCountObservable: Observable<Int> { get }
}

class ProductListHeaderInteractorImp : ProductListHeaderInteractor {
    
    let productsKeeper: ProductsKeeper

    init(productsKeeper: ProductsKeeper) {
        self.productsKeeper = productsKeeper
    }
    
    // MARK: - <ProductDetailInteractor>
    
    var lastUpdatedObservable: Observable<Date?> {
        return productsKeeper.lastUpdatedObservable
    }
    
    var productsCountObservable: Observable<Int> {
        return productsKeeper.observableProducts.map({ (products) in
            return products.count
        })
    }
}
