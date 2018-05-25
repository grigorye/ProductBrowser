//
//  ProductListViewController.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import Then
import UIKit

class ProductListViewController : UITableViewController, ProductListView {
    
    // MARK: - <ProductListView>
    
    weak var delegate: ProductListViewDelegate!

    var itemViewModels: Observable<[ProductListItemViewModel]>! {
        didSet {
            configureView()
        }
    }
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ProductListCell", bundle: .current), forCellReuseIdentifier: "ProductListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate.viewDidDisappear()
    }
    
    private let disposeBag = DisposeBag()

    func configureView() {
        
        tableView.isEditing = false
        
        typealias ItemViewModel = ProductListItemViewModel
        
        let animatedDataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<Int, ItemViewModel>>(configureCell: { _, tableView, indexPath, itemViewModel in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath)
            (cell as! ProductListItemView).model = itemViewModel
            return cell
        })
        
        tableView.dataSource = nil
        
        itemViewModels
            .map { [AnimatableSectionModel(model: 0, items: $0)] }
            .bind(to: tableView.rx.items(dataSource: animatedDataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { [unowned self] indexPath -> ItemViewModel in
                return try self.tableView.rx.model(at: indexPath)
            }
            .subscribe(onNext: { [unowned self] (itemViewModel) in
                self.delegate.selected(itemViewModel)
            })
            .disposed(by: disposeBag)
        
        #if false
        animatedDataSource.canEditRowAtIndexPath = { _, _  in
            return false
        }
        animatedDataSource.canMoveRowAtIndexPath = { _, _  in
            return false
        }
        #endif
    }
}
