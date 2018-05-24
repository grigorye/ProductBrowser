//
//  ProductListPresenter.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift

protocol ProductListPresenter : ProductListViewDelegate {
    
    func loadContent()
}

class ProductListPresenterImp : ProductListPresenter {
    
    // MARK: - <ProductListPresenter>
    
    func loadContent() {
        interactor.clearRefreshing()
        view.itemViewModels = interactor.observableProducts.map { (products) in
            return products.map { ProductListItemViewModel($0) }
        }.debug()
        interactor.refreshProductsAsNecessary()
    }

    // MARK: - <ProductListViewDelegate>
    
    func selected(_ viewModel: ProductListItemViewModel) {
        router.routeToDetail(forProduct: viewModel.product.identifier)
    }

    // MARK: -
    
    let disposeBag = DisposeBag()
    
    let view: ProductListView
    let interactor: ProductListInteractor
    let router: ProductListRouter
    
    init(view: ProductListView, interactor: ProductListInteractor, router: ProductListRouter) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    deinit {()}
}
