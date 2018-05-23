//
//  ProductsModuleImp.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import SwinjectStoryboard
import Swinject
import UIKit

class ProductsModuleImp : ContainerViewModule, ProductsModule {
    
    init(container: Container) {
        
        self.container = container
        
        container.storyboardInitCompleted(ViewController.self) { r, c in
            
            container.register((UIViewController & ContainerView).self) { _ in c }
        }
    }
    
    typealias ContainerView = ProductsView
    
    typealias ViewController = ProductsViewController
    
    typealias Interactor = ()
    
    typealias Presenter = ()
    
    typealias Router = ()
    
    let storyboardName = "Products"

    let container: Container
}
