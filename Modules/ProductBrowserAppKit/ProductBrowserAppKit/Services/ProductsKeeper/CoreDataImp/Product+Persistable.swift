//
//  Product+RxCoreData.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxCoreData

extension Product : Persistable {
    
    typealias T = PersistentProduct

    static var entityName: String {
        return "PersistentProduct"
    }
    
    static var primaryAttributeName: String {
        return #keyPath(PersistentProduct.name)
    }
    
    var identity: String {
        return name
    }
    
    init(entity: PersistentProduct) {
        self.name = entity.name!
        self.category = entity.category!
        self.description = entity.productDescription!
        self.imageURL = entity.imageURL
        self.itemsRemaining = entity.itemsRemaining?.intValue
    }
    
    func update(_ entity: PersistentProduct) {
        entity.name = name
        entity.productDescription = description
        entity.imageURL = imageURL
        entity.itemsRemaining = itemsRemaining.flatMap { NSNumber(value: $0) }
        entity.category = category

        try! entity.managedObjectContext!.save()
    }
}
