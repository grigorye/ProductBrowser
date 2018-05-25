//
//  ProductListHeaderView.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol ProductListHeaderView : View {
    
    var model: ProductListHeaderViewModel! { get set }
}

struct ProductListHeaderViewModel {
    
    let totalProductsText: String
    let lastUpdatedText: String
}
