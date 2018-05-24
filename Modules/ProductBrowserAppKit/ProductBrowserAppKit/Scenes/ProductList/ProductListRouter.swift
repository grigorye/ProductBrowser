//
//  ProductListRouter.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Hero
import Swinject
import UIKit

protocol ProductListRouter {
    
    func routeToDetail(forProduct productIdentifier: ProductIdentifier)
}

struct ProductListRouterImp : ProductListRouter {

    // MARK: - <ProductListRouter>
    
    func routeToDetail(forProduct productIdentifier: ProductIdentifier) {
        
        let detailViewController = newProductDetailViewController(productIdentifier: productIdentifier, container: container)
        present(detailViewController, for: productIdentifier)
    }

    // MARK: -
    
    func present(_ detailViewController: UIViewController, for productIdentifier: ProductIdentifier) {
        
        let navigationController = viewController.navigationController!
        
        if !UserDefaults.standard.bool(forKey: "ForceStandardDetailTransitioning") {
            prepareCustomTransitioning(via: navigationController, for: productIdentifier)
            detailViewController.hero.isEnabled = true
        }
        
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func prepareCustomTransitioning(via navigationController: UINavigationController, for productIdentifier: ProductIdentifier) {
        
        navigationController.hero.isEnabled = true
    }

    // MARK: -
    
    let viewController: UIViewController
    let container: Container
}
