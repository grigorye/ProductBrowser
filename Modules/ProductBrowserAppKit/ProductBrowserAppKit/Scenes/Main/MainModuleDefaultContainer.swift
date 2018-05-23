//
//  DefaultContainer.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

func mainModuleDefaultContainer(parent: Container?) -> Container {
    
    let container = Container(parent: parent)
    
    container.register(MainModule.self, factory: { r in
        return MainModuleImp(container: container)
    }).initCompleted({ (r, main) in
        _ = r.resolve(ProductsModule.self)
    })
    
    container.register(ProductsModule.self, factory: { r in
        return ProductsModuleImp(container: container)
    }).initCompleted({ (r, main) in
        _ = r.resolve(ProductListModule.self)
        _ = r.resolve(ProductListHeaderModule.self)
    })

    container.register(ProductListModule.self, factory: { r in
        return ProductListModuleImp(container: container)
    })
    
    container.register(ProductListHeaderModule.self, factory: { r in
        return ProductListHeaderModuleImp(container: container)
    })
    
    return container
}
