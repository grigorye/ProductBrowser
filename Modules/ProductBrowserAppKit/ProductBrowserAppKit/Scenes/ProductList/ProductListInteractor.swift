//
//  ProductListInteractor.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxCocoa
import RxSwift
import Result
import Then

extension Array : Then {}

protocol ProductListInteractor {
    
    var observableProducts: Observable<[Product]> { get }
    
    func clearRefreshing()
    func refreshAsNecessary()
    
    func startPeriodicRefreshing()
    func stopPeriodicRefreshing()
}

class ProductListInteractorImp : ProductListInteractor {
    
    let productsKeeper: ProductsKeeper
    let productsProvider: ProductsProvider
    let productsRefresher: ProductsRefresher
    let repeatingOnlineEventTrigger: RepeatingOnlineEventTrigger
    let refreshInterval: TimeInterval
    
    deinit {()}
    
    init(productsKeeper: ProductsKeeper, productsProvider: ProductsProvider, productsRefresher: ProductsRefresher, repeatingOnlineEventTrigger: RepeatingOnlineEventTrigger, refreshInterval: TimeInterval) {
        
        self.productsKeeper = productsKeeper
        self.productsProvider = productsProvider
        self.productsRefresher = productsRefresher
        self.repeatingOnlineEventTrigger = repeatingOnlineEventTrigger
        self.refreshInterval = refreshInterval
    }
    
    // MARK: - <ProductListInteractor>
    
    var observableProducts: Observable<[Product]> {
        return productsKeeper.observableProducts
    }
    
    func clearRefreshing() {
        productsRefresher.clearRefreshing()
    }
    
    func refreshAsNecessary() {
        productsRefresher.refreshProductsAsNecessary()
    }
    
    var periodicRefreshToken: AnyObject!
    
    func startPeriodicRefreshing() {
        
        self.periodicRefreshToken = repeatingOnlineEventTrigger.whenOnlineWithPeriod(of: refreshInterval) { [productsRefresher] in
            
            productsRefresher.refreshProductsAsNecessary()
        }
    }
    
    func stopPeriodicRefreshing() {
        self.periodicRefreshToken = nil
    }
}
