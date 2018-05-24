//
//  Networking.swift
//  ProductsApp/OpenProductsMap
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol ProductsNetworking {

    func queryProducts(completion: @escaping (ProductsNetworkingQueryResult) -> Void)
}
