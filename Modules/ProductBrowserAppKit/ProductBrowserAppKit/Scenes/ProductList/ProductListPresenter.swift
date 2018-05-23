//
//  ProductListPresenter.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol ProductListPresenter : ProductListViewDelegate {
    
}

class ProductListPresenterImp : ProductListPresenter {
    
    // MARK: - <ProductListViewDelegate>
    
    func didSelectItem(at index: Int) {
        
        router.routeToDetail(forProduct: "X")
    }
    
    
    // MARK: -
    
    let router: ProductListRouter
    
    init(router: ProductListRouter) {
        
        self.router = router
    }

    deinit {()}
}
