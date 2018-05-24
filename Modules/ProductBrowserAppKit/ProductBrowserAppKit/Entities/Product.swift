//
//  Product.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation

struct Product : Equatable {
    
    let name: String
    let category: String
    let itemsRemaining: Int?
    let imageURL: URL?
    let description: String
}

extension Product {
    
    var identifier: ProductIdentifier {
        return ProductIdentifier(stringLiteral: name)
    }
}
