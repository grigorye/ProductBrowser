//
//  Product+PersistableTests.swift
//  ProductBrowserAppKitTests
//
//  Created by Grigory Entin on 15/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import ProductBrowserAppKit
import CoreData

class Product_PersistableTests : QuickSpec {
    
    override func spec() {
        context("when persisted") {
            let mom = Bundle.current.managedObjectModel(withName: "Products")!
            let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
            try! psc.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
            let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType).then {
                $0.persistentStoreCoordinator = psc
            }
            
            let product = Product(
                name: "iPad mini",
                category: "tablet",
                itemsRemaining: 5,
                imageURL: URL(string: "http://i-repairservice.com/i-repairservice.com/wp-content/uploads/2013/12/ipad1_2.jpga50d29f8-c0fc-461d-b3ad-97261c0d5e38Large.jpg")!,
                description: "The first-generation iPad is a tablet computer designed and marketed by Apple Inc. as the first in the iPad line. The device features an Apple A4 processor, a 9.7\" touchscreen display, and on certain variants the capability of accessing cellular networks. Using the iOS operating system, the iPad can play music, send and receive email and browse the web. Other functions, which include the ability to play games and access references, GPS navigation software and social network services can be enabled by downloading apps.\n\nThe device was announced and unveiled on January 27, 2010 at a media conference. On April 4, 2010, the Wi-Fi variant of the device was released in the United States, followed by the release of the Wi-Fi + Cellular variant on April 30. On May 28, it was released in Australia, Canada, France, Japan, Italy, Germany, Spain, Switzerland and the United Kingdom.\n\nThe device received primarily positive reviews from various technology blogs and publications. Reviewers praised the device for its wide range of capabilities and labelled it as a competitor to laptops and netbooks. Some aspects were criticized, including the closed nature of the operating system and the lack of support for the Adobe Flash multimedia format. During the first 80 days, three million iPads were sold. By the launch of the iPad 2, Apple sold more than 15 million iPads.\n\nOn March 2, 2011, Apple announced the new iPad 2 and the discontinuation of production of the original iPad.[6]"
            )
            let persistentProduct = PersistentProduct(context: moc)
            product.update(persistentProduct)
            it("should match original after recreated") {
                let updatedProduct = Product(entity: persistentProduct)
                expect(updatedProduct) == product
                _ = moc // Keep moc around given that "it" is invoked after leaving the "context".
            }
        }
    }
}
