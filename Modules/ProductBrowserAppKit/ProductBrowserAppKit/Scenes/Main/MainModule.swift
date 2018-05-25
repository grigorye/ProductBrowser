//
//  MainModule.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject
import UIKit

protocol MainModule {
    
    func newViewController() -> UIViewController
}

public func newMainViewController(container: Container? = sharedContainer) -> UIViewController {
    
    return mainModuleDefaultContainer(parent: container).resolve(MainModule.self)!.newViewController()
}
