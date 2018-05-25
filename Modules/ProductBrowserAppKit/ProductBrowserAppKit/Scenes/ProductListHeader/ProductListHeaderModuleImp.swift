//
//  ProductListHeaderModuleImp.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import SwinjectStoryboard
import Swinject
import UIKit

class ProductListHeaderModuleImp : ViewModule, ProductListHeaderModule {
    
    typealias PresenterImp = ProductListHeaderPresenterImp
    typealias InteractorImp = ProductListHeaderInteractorImp

    static func configure(_ view: View, viewController: UIViewController, with container: Container)  {
        
        let presenter = container.resolve(Presenter.self)!
        viewController.retainObject(presenter)
        
        presenter.loadContent()
    }
    
    init(container parentContainer: Container) {
        
        let container = Container(parent: parentContainer)
        
        self.container = container
        
        container.register(Presenter.self) { r in
            return PresenterImp(
                view: r.resolve(View.self)!,
                interactor: r.resolve(Interactor.self)!,
                lastUpdatedDateFormatter: r.resolve(DateFormatter.self, name: "lastUpdatedDateFormatter")!
            )
        }
        
        container.register(Interactor.self) { r in
            return InteractorImp(
                productsKeeper: r.resolve(ProductsKeeper.self)!
            )
        }
        
        container.register(DateFormatter.self, name: "lastUpdatedDateFormatter") { r in
            return DateFormatter().with {
                $0.timeStyle = .medium
            }
        }
        
        parentContainer.storyboardInitCompleted(ViewController.self) { r, c in
            
            container.register((UIViewController & View).self) { _ in c }
            container.register((View).self) { _ in c }

            ProductListHeaderModuleImp.configure(c, viewController: c, with: container)
        }
    }
    
    typealias View = ProductListHeaderView
    
    typealias ViewController = ProductListHeaderViewController
    
    typealias Interactor = ProductListHeaderInteractor
    
    typealias Presenter = ProductListHeaderPresenter
    
    typealias Router = ()
    
    let storyboardName = "ProductListHeader"

    let container: Container
}
