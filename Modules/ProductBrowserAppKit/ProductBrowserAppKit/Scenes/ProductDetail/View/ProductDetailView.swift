//
//  ProductDetailView.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol ProductDetailView : View {
    
    var model: ProductDetailViewModel! { get set }
}

struct ProductDetailViewModel {
    
    let imageURL: URL?
    let titleText: String
    let detailText: NSAttributedString
}
