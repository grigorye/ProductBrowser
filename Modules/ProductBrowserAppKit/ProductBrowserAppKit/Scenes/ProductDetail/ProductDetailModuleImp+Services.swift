//
//  ProductDetailModule+Services.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

extension ProductDetailModuleImp {
    
    func registerServices(in container: Container) {
        
        container.register(ProductsKeeper.self) { r in
            return CoreDataProductsKeeper()
        }
    }
}
