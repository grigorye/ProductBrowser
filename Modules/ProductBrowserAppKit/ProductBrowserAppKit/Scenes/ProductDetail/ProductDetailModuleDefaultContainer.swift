//
//  ProductDetailModuleDefaultContainer.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

func productDetailModuleDefaultContainer(parent: Container, productIdentifier: ProductIdentifier) -> Container {
    
    let container = Container(parent: parent)
        
    container.register(ProductDetailModule.self, factory: { r in
        return ProductDetailModuleImp(container: container, productIdentifier: productIdentifier)
    })
    
    return container
}
