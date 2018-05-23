//
//  ProductListHeaderViewController.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class ProductListHeaderViewController : UIViewController, ProductListHeaderView {

    // MARK: - <ProductListHeaderView>
    
    var model: ProductListHeaderViewModel! {
        didSet {
            totalProductsLabel.text = model.totalProductsText
            lastUpdatedLabel.text = model.lastUpdatedText
        }
    }
    
    // MARK: -
    
    var totalProductsLabel: UILabel {
        _ = view
        return _totalProductsLabel
    }
    
    @IBOutlet var _totalProductsLabel: UILabel!
    
    var lastUpdatedLabel: UILabel {
        _ = view
        return _lastUpdatedLabel
    }
    
    @IBOutlet var _lastUpdatedLabel: UILabel!
}
