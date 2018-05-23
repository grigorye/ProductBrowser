//
//  ProductDetailPresenter.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol ProductDetailPresenter : AnyObject {
    
    init(productIdentifier: ProductIdentifier)
}

class ProductDetailPresenterImp : ProductDetailPresenter {
    
    // MARK: - <ProductDetailPresenter>

    required init(productIdentifier: ProductIdentifier) {
        
        self.productIdentifier = productIdentifier
    }
    
    // MARK: -
    
    let productIdentifier: ProductIdentifier
    
    deinit {()}
}
