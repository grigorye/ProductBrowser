//
//  ProductListCell.swift
//  ProductBrowserApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import SDWebImage
import Hero
import UIKit

class ProductListCell : UITableViewCell, ProductListItemView {
    
    // MARK: - <ProductListItemView>
    
    var modelDisposeBag: DisposeBag!
    var model: ProductListItemViewModel! {
        didSet {
            iconView.hero.id = model.iconHeroID
            iconView.sd_cancelCurrentAnimationImagesLoad()
            iconView.sd_setImage(with: model.iconURL)
            titleLabel.hero.id = model.titleHeroID
            titleLabel.text = model.title
        }
    }
    
    // MARK: -
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconView.hero.id = nil
        iconView.sd_cancelCurrentAnimationImagesLoad()
        titleLabel.hero.id = nil
    }
    
    // MARK: -
    
    var iconView: UIImageView {
        return _iconView!
    }
    
    @IBOutlet private var _iconView: UIImageView!
    
    var titleLabel: UILabel {
        return _titleLabel!
    }
    
    @IBOutlet private var _titleLabel: UILabel!
}
