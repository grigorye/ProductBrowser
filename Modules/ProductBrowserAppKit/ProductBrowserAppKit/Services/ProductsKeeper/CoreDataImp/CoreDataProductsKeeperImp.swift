//
//  CoreDataProductsImp.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import RxCoreData
import Then
import CoreData

class CoreDataProductsKeeper : ProductsKeeper {
    
    var lastUpdated: Date? {
        set {
            lastUpdatedBehaviorSubject.onNext(newValue)
        }
        get {
            return try! lastUpdatedBehaviorSubject.value()
        }
    }
    var lastUpdatedBehaviorSubject = BehaviorSubject<Date?>(value: nil)
    var lastUpdatedObservable: Observable<Date?> {
        return lastUpdatedBehaviorSubject
    }

    var lastError: Error?

    let sortDescriptors = [
        NSSortDescriptor(key: #keyPath(PersistentProduct.dateAdded), ascending: true)
    ]

    var products: [Product] {
        get {
            let request: NSFetchRequest<PersistentProduct> = PersistentProduct.fetchRequest().with {
                $0.sortDescriptors = sortDescriptors
            }
            let persistentProducts = try! managedObjectContext.fetch(request)
            let products = persistentProducts.map { Product(entity: $0) }
            return products
        }
        set {
            newValue.forEach {
                try! managedObjectContext.rx.update($0)
            }
            let newProductIdentifiers = newValue.map { $0.identifier }
            let deletedProducts = products.filter { !newProductIdentifiers.contains($0.identifier) }
            deletedProducts.forEach {
                try! managedObjectContext.rx.delete($0)
            }
        }
    }
    
    // MARK: - <ProductsKeeper>
    
    lazy var observableProducts: Observable<[Product]> = {
        return
            managedObjectContext.rx
                .entities(Product.self, sortDescriptors: sortDescriptors)
                .share(replay: 1, scope: .forever)
    }()
    
    // MARK: -
    
    private(set) public static var managedObjectModel = Bundle.current.managedObjectModel(withName: "Products")!
    
    private var managedObjectContext: NSManagedObjectContext
    
    convenience init() {
        let persistentContainer = NSPersistentContainer(name: "Products", managedObjectModel: type(of: self).managedObjectModel).then { (container) in
            container.loadPersistentStoresDestroyingStoreOnMigrationError { (storeDescription, error) in
                if let error = error {
                    fatalError("error: \(error), persistentStore: \(storeDescription)")
                }
            }
        }
        self.init(with: persistentContainer.viewContext)
    }
    
    init(with managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    deinit {()}
}
