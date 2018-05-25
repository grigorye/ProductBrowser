//
//  ProductsKeeper.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift

protocol ProductsKeeper : class {

    var products: [Product] { get set }
    var lastUpdated: Date? { get set }
    var lastUpdatedObservable: Observable<Date?> { get }
    var lastError: Error? { get set }
    
    var observableProducts: Observable<[Product]> { get }
}
