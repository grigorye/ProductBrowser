//
//  ProductListHeaderPresenter.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import UIKit

protocol ProductListHeaderPresenter : AnyObject {
    
    func loadContent()
}

class ProductListHeaderPresenterImp : ProductListHeaderPresenter {
    
    let view: ProductListHeaderView
    let interactor: ProductListHeaderInteractor
    
    init(view: ProductListHeaderView, interactor: ProductListHeaderInteractor, lastUpdatedDateFormatter: DateFormatter) {
        self.view = view
        self.interactor = interactor
        self.lastUpdatedDateFormatter = lastUpdatedDateFormatter
    }
    
    let lastUpdatedDateFormatter: DateFormatter
    
    let disposeBag = DisposeBag()
    
    // MARK: - <ProductListHeaderPresenter>
    
    func lastUpdatedText(for date: Date?) -> String {
        guard let date = date else {
            return NSLocalizedString("Never Updated", comment: "")
        }
        let dateString = lastUpdatedDateFormatter.string(from: date)
        return String(
            format: NSLocalizedString("Last Updated: %@", comment: ""),
            dateString
        )
    }
    
    func loadContent() {
        
        interactor.lastUpdatedObservable
            .subscribe(onNext: { [unowned self, view] (lastUpdated) in
                let text = self.lastUpdatedText(for: lastUpdated)
                view.model = ProductListHeaderViewModel(
                    totalProductsText: view.model?.totalProductsText ?? "",
                    lastUpdatedText: text
                )
            })
            .disposed(by: disposeBag)
        
        interactor.productsCountObservable
            .subscribe(onNext: { [view] (productsCount) in
                let text = String(format: NSLocalizedString("%d products", comment: ""), productsCount)
                view.model = ProductListHeaderViewModel(
                    totalProductsText: text,
                    lastUpdatedText: view.model?.lastUpdatedText ?? ""
                )
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: -
    
    deinit {()}
}
