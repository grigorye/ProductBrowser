//
//  ProductDetailViewController.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class ProductDetailViewController : UIViewController, ProductDetailView {
    
    // MARK: - <ProductDetailView>
    
    var model: ProductDetailViewModel! {
        didSet {
            
        }
    }
    
    // MARK: -
    
    var imageView: UIImageView {
        _ = view
        return _imageView
    }
    
    @IBOutlet private var _imageView: UIImageView!
}
