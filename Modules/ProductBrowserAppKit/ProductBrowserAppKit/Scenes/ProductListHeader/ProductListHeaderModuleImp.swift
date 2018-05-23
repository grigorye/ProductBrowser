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
    
    static func configure(_ view: View, viewController: UIViewController, with container: Container)  {
        
        let presenter = container.resolve(Presenter.self)!
        viewController.retainObject(presenter)
    }
    
    init(container: Container) {
        
        self.container = container
        
        container.register(Presenter.self) { r in
            return PresenterImp()
        }
        
        container.storyboardInitCompleted(ViewController.self) { r, c in
            
            container.register((UIViewController & View).self) { _ in c }
            
            ProductListHeaderModuleImp.configure(c, viewController: c, with: container)
        }
    }
    
    typealias View = ProductListHeaderView
    
    typealias ViewController = ProductListHeaderViewController
    
    typealias Interactor = ()
    
    typealias Presenter = ProductListHeaderPresenter
    
    typealias Router = ()
    
    let storyboardName = "ProductListHeader"

    let container: Container
}
