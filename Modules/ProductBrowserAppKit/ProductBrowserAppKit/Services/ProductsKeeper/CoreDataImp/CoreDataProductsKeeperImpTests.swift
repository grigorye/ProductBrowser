//
//  CoreDataProductsKeeperImpTests.swift
//  ProductBrowserAppKitTests
//
//  Created by Grigory Entin on 19/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import ProductBrowserAppKit
import CoreData

func coreDataProductsImpTestKeeper() -> ProductsKeeper {
    let mom = CoreDataProductsKeeper.managedObjectModel
    let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
    try! psc.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType).then {
        $0.persistentStoreCoordinator = psc
    }
    return CoreDataProductsKeeper(with: moc)
}

class CoreDataProductsKeeperImpTests : QuickSpec {
    
    override func spec() {
        
        context("") {
            it("might be constructed") {
                _ = CoreDataProductsKeeper()
            }
        }
    }
}
