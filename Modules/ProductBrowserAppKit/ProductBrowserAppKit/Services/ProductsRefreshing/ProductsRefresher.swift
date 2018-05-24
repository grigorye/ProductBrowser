//
//  ProductsRefresher.swift
//  ProductsApp
//
//  Created by Grigory Entin on 15/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol ProductsRefresher {
    
    func refreshProductsAsNecessary()
    func clearRefreshing()
}
