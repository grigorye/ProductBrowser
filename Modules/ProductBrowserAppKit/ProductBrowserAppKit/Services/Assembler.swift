//
//  Assembler.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 25/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject
import Then

extension Container : Then {}

private var assembler: Assembler!

public let sharedContainer = Container().with {
    assembler = Assembler([ServicesAssembly()], container: $0)
}
