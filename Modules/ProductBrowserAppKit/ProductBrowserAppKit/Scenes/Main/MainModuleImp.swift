//
//  MainModule.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import SwinjectStoryboard
import Swinject
import UIKit

struct MainModuleImp : ContainerViewModule, MainModule {
    
    init(container: Container) {
        
        self.container = container
        
        container.storyboardInitCompleted(ViewController.self) { [container] r, c in
            
            container.register((UIViewController & ContainerView).self) { _ in c }
        }
    }

    // MARK: - <ContainerViewModule>
    
    typealias ContainerView = MainView
    
    typealias ViewController = MainViewController
    
    typealias Interactor = ()
    
    typealias Presenter = ()
    
    typealias Router = ()
    
    let storyboardName = "Main"

    let container: Container
}
