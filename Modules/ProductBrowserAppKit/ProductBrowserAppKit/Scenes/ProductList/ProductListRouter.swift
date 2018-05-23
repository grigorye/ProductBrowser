//
//  ProductListRouter.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject
import UIKit

protocol ProductListRouter {
    
    func routeToDetail(forProduct productIdentifier: ProductIdentifier)
}

struct ProductListRouterImp : ProductListRouter {

    // MARK: - <ProductListRouter>
    
    func routeToDetail(forProduct productIdentifier: ProductIdentifier) {
        
        let detailViewController = newProductDetailViewController(productIdentifier: productIdentifier, container: container)
        viewController.navigationController!.pushViewController(detailViewController, animated: true)
    }

    // MARK: -
    
    let viewController: UIViewController & ProductListView
    let container: Container
}
