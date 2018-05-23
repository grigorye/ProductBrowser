//
//  VIPERModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import SwinjectStoryboard
import Swinject

protocol ContainerView : class {}

protocol View : class {
}

protocol ModuleStoryboarding {
    
    var storyboardName: String { get }
    var container: Container { get }
}

protocol ModuleNonView {
    
    associatedtype Interactor
    associatedtype Presenter
    associatedtype Router
}

typealias _View = View

protocol ViewModule : ModuleNonView, ModuleStoryboarding {
    
    associatedtype View
    associatedtype ViewController: _View
}

typealias _ContainerView = ContainerView

protocol ContainerViewModule : ModuleNonView, ModuleStoryboarding {
    
    associatedtype ContainerView
    associatedtype ViewController: _ContainerView
}

import UIKit

extension ModuleStoryboarding {
    
    func instantiateViewController() -> UIViewController {
        
        let storyboard: UIStoryboard = SwinjectStoryboard.create(name: storyboardName, bundle: .current, container: container)
        let viewController = storyboard.instantiateInitialViewController()!
        
        return viewController
    }
}

extension ViewModule where Interactor == () {
    
    func newViewController() -> UIViewController {
        
        return instantiateViewController()
    }
}

extension ContainerViewModule {
    
    func newViewController() -> UIViewController {
        
        return instantiateViewController()
    }
}
