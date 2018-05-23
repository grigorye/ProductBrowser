//
//  ProductDetailModule.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject
import UIKit

protocol ProductDetailModule {
    
    func newViewController() -> UIViewController
}

public func newProductDetailViewController(productIdentifier: ProductIdentifier, container: Container) -> UIViewController {
    
    let container = productDetailModuleDefaultContainer(parent: container, productIdentifier: productIdentifier)
    
    return container.resolve(ProductDetailModule.self)!.newViewController()
}
