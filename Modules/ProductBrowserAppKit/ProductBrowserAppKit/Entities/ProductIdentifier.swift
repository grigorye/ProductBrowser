//
//  ProductIdentifier.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

public struct ProductIdentifier : ExpressibleByStringLiteral, Codable, Equatable {
    
    public typealias StringLiteralType = String
    
    let stringLiteral: String
    
    public init(stringLiteral: String) {
        
        self.stringLiteral = stringLiteral
    }
}
