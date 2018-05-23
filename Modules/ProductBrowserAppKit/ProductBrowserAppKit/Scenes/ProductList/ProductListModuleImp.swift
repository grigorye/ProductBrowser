//
//  ProductListModuleImp.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import SwinjectStoryboard
import Swinject
import UIKit

class ProductListModuleImp : ViewModule, ProductListModule {
    
    typealias PresenterImp = ProductListPresenterImp
    typealias RouterImp = ProductListRouterImp
    
    static func configure(_ view: View, viewController: UIViewController, with container: Container)  {
        
        let presenter = container.resolve(Presenter.self)!
        view.delegate = presenter
        viewController.retainObject(presenter)
    }
    
    init(container: Container) {
        
        self.container = container
        
        container.register(Presenter.self) { r in
            return PresenterImp(router: r.resolve(Router.self)!)
        }
        
        container.register(Router.self) { r in
            return RouterImp(
                viewController: r.resolve((UIViewController & View).self)!,
                container: container
            )
        }
        
        container.storyboardInitCompleted(ViewController.self) { r, c in
            
            container.register((UIViewController & View).self) { _ in c }
            
            ProductListModuleImp.configure(c, viewController: c, with: container)
        }
    }
    
    typealias View = ProductListView
    
    typealias ViewController = ProductListViewController
    
    typealias Interactor = ()
    
    typealias Presenter = ProductListPresenter
    
    typealias Router = ProductListRouter
    
    let storyboardName = "ProductList"

    let container: Container
}
