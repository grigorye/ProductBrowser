//
//  ProductListModule+Services.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

extension ProductListModuleImp {
    
    func registerServices(in container: Container) {
        
        container.register(ProductsKeeper.self) { r in
            return CoreDataProductsKeeper()
        }
        
        container.register(NetworkProductsProviderImp.Networking.self) { r in
            return MoyaProductsNetworkingImp()
        }
        
        container.register(ProductsProvider.self) { r in
            let networking = container.resolve(NetworkProductsProviderImp.Networking.self)!
            return NetworkProductsProviderImp(
                networking: networking
            )
        }
        
        container.register(ProductsRefresher.self) { r in
            return ProductsRefresherImp(
                productsProvider: container.resolve(ProductsProvider.self)!,
                productsKeeper: container.resolve(ProductsKeeper.self)!
            )
        }
        
        container.register(RepeatingOnlineEventTrigger.self) { r in
            return RepeatingOnlineEventTriggerImp()
        }
    }
}
