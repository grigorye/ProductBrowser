//
//  ProductListViewController.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class ProductListViewController : UITableViewController, ProductListView {
    
    // MARK: - <ProductListView>
    
    var model: ProductListViewModel!
    
    weak var delegate: ProductListViewDelegate!
    
    // MARK: - <UITableViewDelegate>
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate.didSelectItem(at: indexPath.row)
    }
}
