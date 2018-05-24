//
//  ProductDetailInteractor.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 24/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol ProductDetailInteractor {
    
    func product(with identifier: ProductIdentifier) -> Product
}

class ProductDetailInteractorImp : ProductDetailInteractor {
    
    let productsKeeper: ProductsKeeper

    init(productsKeeper: ProductsKeeper) {
        self.productsKeeper = productsKeeper
    }
    
    // MARK: - <ProductDetailInteractor>
    
    func product(with identifier: ProductIdentifier) -> Product {
        return productsKeeper.products.first(where: { $0.identifier == identifier })!
    }
}
