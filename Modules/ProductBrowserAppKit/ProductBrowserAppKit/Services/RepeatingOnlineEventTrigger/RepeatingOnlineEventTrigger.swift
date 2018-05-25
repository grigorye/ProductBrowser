//
//  ProductsAutorefresher.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 25/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation.NSDate

protocol RepeatingOnlineEventTrigger {
    
    func whenOnlineWithPeriod(of: TimeInterval, do handler: @escaping () -> ()) -> AnyObject
}
