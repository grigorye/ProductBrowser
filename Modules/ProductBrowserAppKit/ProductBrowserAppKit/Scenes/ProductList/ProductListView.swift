//
//  ProductListView.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit
import RxSwift

protocol ProductListView : View {
    
    var delegate: ProductListViewDelegate! { get set }
    var itemViewModels: Observable<[ProductListItemViewModel]>! { get set }
}

protocol ProductListViewDelegate : AnyObject {
    
    func selected(_: ProductListItemViewModel)
}
