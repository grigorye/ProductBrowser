//
//  ProductListView.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol ProductListView : View {
    
    var delegate: ProductListViewDelegate! { get set }
}

struct ProductListViewModel {
    
    let items: [Item]
    
    struct Item {
        
        let image: UIImage
        let title: String
    }
}

protocol ProductListViewDelegate : AnyObject {
    
    func didSelectItem(at index: Int)
}
