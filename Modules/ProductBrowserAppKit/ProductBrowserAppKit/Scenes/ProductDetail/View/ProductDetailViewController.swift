//
//  ProductDetailViewController.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import SDWebImage
import UIKit

class ProductDetailViewController : UIViewController, ProductDetailView {
    
    // MARK: - <ProductDetailView>
    
    var model: ProductDetailViewModel! {
        didSet {
            configureView()
        }
    }
    
    // MARK: -
    
    func configureView() {
        imageView.hero.id = model.imageHeroID
        imageView.sd_setImage(with: model.imageURL)
        titleLabel.hero.id = model.titleHeroID
        titleLabel.text = model.titleText
        detailLabel.attributedText = model.detailText
    }
    
    // MARK: -
    
    var imageView: UIImageView {
        _ = view
        return _imageView
    }
    
    @IBOutlet private var _imageView: UIImageView!
    
    var titleLabel: UILabel {
        _ = view
        return _titleLabel
    }
    
    @IBOutlet var _titleLabel: UILabel!

    var detailLabel: UILabel {
        _ = view
        return _detailLabel
    }
    
    @IBOutlet var _detailLabel: UILabel!
}
