//
//  AppModule.swift
//  ProductBrowserApp
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit
import ProductBrowserAppKit

func newAppWindow() -> UIWindow {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let mainViewController = newMainViewController()
    window.rootViewController = mainViewController
    return window
}
