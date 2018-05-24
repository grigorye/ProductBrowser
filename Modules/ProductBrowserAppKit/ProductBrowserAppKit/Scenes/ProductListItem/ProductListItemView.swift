//
//  ProductListItemView.swift
//  ProductBrowserApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift

protocol ProductListItemView : class {
    
    var model: ProductListItemViewModel! { get set }
}

struct ProductListItemViewModel {
    
    let titleHeroID: String
    let title: String
    let iconHeroID: String
    let iconURL: URL?

    let identifier: String
    let userInfo: Any!
}
