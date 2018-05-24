//
//  ProductListItemView+Differentiator.swift
//  ProductBrowserApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Differentiator

extension ProductListItemViewModel : Equatable {}

func == (lhs: ProductListItemViewModel, rhs: ProductListItemViewModel) -> Bool {
    return (lhs.identifier == rhs.identifier)
}

extension ProductListItemViewModel : IdentifiableType {
    
    typealias Identity = String
    
    var identity: String {
        return identifier
    }
}
