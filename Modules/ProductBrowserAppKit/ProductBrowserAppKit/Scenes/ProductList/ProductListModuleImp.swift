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
    
    typealias InteractorImp = ProductListInteractorImp
    typealias PresenterImp = ProductListPresenterImp
    typealias RouterImp = ProductListRouterImp
    
    static func configure(_ view: View, viewController: UIViewController, with container: Container)  {
        
        let presenter = container.resolve(Presenter.self)!
        view.delegate = presenter
        viewController.retainObject(presenter)
        
        presenter.loadContent()
    }
    
    init(container parentContainer: Container) {
        
        let container = Container(parent: parentContainer)
        self.container = container

        registerServices(in: container)
        
        container.register(Presenter.self) { r in
            return PresenterImp(
                view: r.resolve(View.self)!,
                interactor: r.resolve(Interactor.self)!,
                router: r.resolve(Router.self)!
            )
        }
        
        container.register(Interactor.self) { r in
            return InteractorImp(
                productsKeeper: r.resolve(ProductsKeeper.self)!,
                productsProvider: r.resolve(ProductsProvider.self)!,
                productsRefresher: r.resolve(ProductsRefresher.self)!,
                repeatingOnlineEventTrigger: r.resolve(RepeatingOnlineEventTrigger.self)!,
                refreshInterval: 5
            )
        }
        
        container.register(Router.self) { r in
            return RouterImp(
                viewController: r.resolve((UIViewController & View).self)!,
                container: container
            )
        }
        
        parentContainer.storyboardInitCompleted(ViewController.self) { r, c in
            
            container.register((UIViewController & View).self) { _ in c }
            container.register(View.self) { _ in c }

            ProductListModuleImp.configure(c, viewController: c, with: container)
        }
    }
    
    // MARK: - <ViewModule>
    
    typealias View = ProductListView
    
    typealias ViewController = ProductListViewController
    
    typealias Interactor = ProductListInteractor
    
    typealias Presenter = ProductListPresenter
    
    typealias Router = ProductListRouter
    
    let storyboardName = "ProductList"

    let container: Container
}
