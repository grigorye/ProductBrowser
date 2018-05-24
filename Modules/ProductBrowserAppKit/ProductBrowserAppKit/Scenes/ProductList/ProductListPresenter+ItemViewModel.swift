//
//  ProductListPresenter+ItemViewModel.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 17/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

extension ProductListItemViewModel {
    
    init(_ product: Product) {
        self.identifier = product.name // !!!
        
        self.iconHeroID = "productImage-\(product.identifier)"
        self.iconURL = product.imageURL
        self.titleHeroID = "productTitle-\(product.identifier)"
        self.title = product.name
        self.userInfo = product
    }
    
    var product: Product {
        return self.userInfo as! Product
    }
}
