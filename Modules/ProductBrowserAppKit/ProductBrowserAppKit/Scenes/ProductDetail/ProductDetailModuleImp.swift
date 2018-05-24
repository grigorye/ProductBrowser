//
//  ProductDetailModuleImp.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import SwinjectStoryboard
import Swinject
import UIKit

class ProductDetailModuleImp : ViewModule, ProductDetailModule {
    
    typealias PresenterImp = ProductDetailPresenterImp
    typealias InteractorImp = ProductDetailInteractorImp

    static func configure(_ view: View, viewController: UIViewController, with container: Container)  {
        
        let presenter = container.resolve(Presenter.self)!
        viewController.retainObject(presenter)
        
        presenter.loadContent()
    }
    
    init(container: Container, productIdentifier: ProductIdentifier) {
        
        self.container = Container(parent: container)
        
        container.register(Presenter.self) { r in
            return PresenterImp(
                view: r.resolve(View.self)!,
                productIdentifier: productIdentifier,
                interactor: r.resolve(Interactor.self)!
            )
        }
        container.register(Interactor.self) { r in
            return InteractorImp(
                productsKeeper: r.resolve(ProductsKeeper.self)!
            )
        }

        container.storyboardInitCompleted(ViewController.self) { r, c in
            
            container.register((UIViewController & View).self) { _ in c }
            container.register((View).self) { _ in c }

            ProductDetailModuleImp.configure(c, viewController: c, with: container)
        }
    }
    
    // MARK: - <ViewModule>
    
    typealias View = ProductDetailView
    
    typealias ViewController = ProductDetailViewController
    
    typealias Interactor = ProductDetailInteractor
    
    typealias Presenter = ProductDetailPresenter
    
    typealias Router = ()
    
    let storyboardName = "ProductDetail"

    let container: Container
}
