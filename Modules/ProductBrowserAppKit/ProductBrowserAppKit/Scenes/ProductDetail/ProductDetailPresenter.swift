//
//  ProductDetailPresenter.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol ProductDetailPresenter : AnyObject {
    
    func loadContent()
}

class ProductDetailPresenterImp : ProductDetailPresenter {
    
    let view: ProductDetailView
    let productIdentifier: ProductIdentifier
    let interactor: ProductDetailInteractor

    init(view: ProductDetailView, productIdentifier: ProductIdentifier, interactor: ProductDetailInteractor) {
        self.view = view
        self.productIdentifier = productIdentifier
        self.interactor = interactor
    }
    
    // MARK: - <ProductDetailPresenter>
    
    func loadContent() {
        
        let product = interactor.product(with: productIdentifier)
        view.model = ProductDetailViewModel(
            imageHeroID: "productImage-\(productIdentifier)",
            imageURL: product.imageURL,
            titleHeroID: "productTitle-\(productIdentifier)",
            titleText: product.name,
            detailText: try! .init(data: product.description.data(using: .unicode)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        )
    }
    
    // MARK: -
    
    deinit {()}
}
