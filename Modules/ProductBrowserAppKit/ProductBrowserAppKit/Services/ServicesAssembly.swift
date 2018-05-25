//
//  ServicesAssembly.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 25/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

class ServicesAssembly : Assembly {
    
    func assemble(container: Container) {
        
        container.register(ProductsKeeper.self) { r in
            return CoreDataProductsKeeper()
        }.inObjectScope(.container)
        
        container.register(NetworkProductsProviderImp.Networking.self) { r in
            return MoyaProductsNetworkingImp()
        }.inObjectScope(.container)
        
        container.register(ProductsProvider.self) { r in
            let networking = container.resolve(NetworkProductsProviderImp.Networking.self)!
            return NetworkProductsProviderImp(
                networking: networking
            )
        }.inObjectScope(.container)
        
        container.register(ProductsRefresher.self) { r in
            return ProductsRefresherImp(
                productsProvider: container.resolve(ProductsProvider.self)!,
                productsKeeper: container.resolve(ProductsKeeper.self)!
            )
        }.inObjectScope(.container)
        
        container.register(RepeatingOnlineEventTrigger.self) { r in
            return RepeatingOnlineEventTriggerImp()
        }.inObjectScope(.container)
    }
}
