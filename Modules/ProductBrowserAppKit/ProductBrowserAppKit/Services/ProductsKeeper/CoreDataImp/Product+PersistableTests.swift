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
                imageURL: URL(string: "http://www.newlaunches.com/wp-content/uploads/2013/04/pad-mini.jpg")!,
                description: "<b>Pros</b><br><ul><li>Stunning brushed metal design</li><li>Strong battery life</li><li>Simply, intuitive UI</li></ul><br><b>Cons</b><br><ul><li>Low-res screen</li><li>More expensive than competition<li>No boxed headphones or dock adaptor</ul><br><b>Key Features:</b> 7.9-inch, 1024 x 768p IPS display; Lightning port connector; iOS 6<br>Manufacturer: Apple<br><br>The iPad mini is still available to buy but you shouldn't confuse it with the new iPad mini 2 Retina which looks exactly the same but is more expensive and has some significant improvements over its predecessor.<br><br><b>Key differences between the iPad mini and iPad mini 2:</b><br><br><b>Screen:</b><br><br>The newer iPad mini comes with a Retina display. This offers a much higher resolution than the original iPad mini and it really tells. The screen is much sharper and brighter - it's one of the best tablet screens around. That's not to say that the original iPad mini's screen is rubbish. In fact it's decent. Video and pictures look good, it's when reading text that you'll wish for a higher resolution.<br><br><b>Processor:</b><br><br>The iPad mini comes with the iPad 2's A5 processor in tow. It's a little long in the tooth now but has no problem running apps. The newer iPad mini comes with the same processor as the iPhone 5S, the 64-bit A7. You'll find that 3D games, like Infinity Blade 3, offer more detail and 3D effects on the Retina screen of the new iPad mini. If you want to use heavy duty apps like 3D rendering and video/photo editing you may want to pick up the more expensive iPad mini, but if not the processor jump is less of an issue than the screen.<br><br><b>Camera:</b><br><br>The new iPad mini has a slightly better front and rear camera. You'll get better shots in lower light conditions with it.<br><br><b>Battery life:</b><br><br>Both iPad minis last about the same amount of time - 10 hours of constant use.<br><br><b>Cost:</b><br><br>This is the other big difference between the original iPad mini and the new one. The original has dropped in price and costs £249 for the entry level 16GB Wi-Fi only model. The iPad mini Retina costs £70 at £319. If you only intend to use your iPad for light apps and browsing then the original iPad mini should suffice, but if you can afford the extra £70 you won't be disappointed by the stunning screen on the newer model."
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
