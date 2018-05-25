//
//  RepeatingOnlineEventTriggerImp.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 25/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import Reachability

class RepeatingOnlineEventTriggerImp : RepeatingOnlineEventTrigger {
    
    let reachabilityService = try! DefaultReachabilityService()
    
    enum Error : Swift.Error {
        case noConnection
    }
    
    func whenOnlineWithPeriod(of interval: TimeInterval, do handler: @escaping () -> ()) -> AnyObject {
        let disposeBag = DisposeBag()
        Observable<Int>.interval(interval, scheduler: MainScheduler.instance)
            .startWith(-1)
            .flatMap { [reachabilityService] _ in
                return reachabilityService.reachability.map { status in
                    if case .unreachable = status {
                        throw Error.noConnection
                    }
                }
            }
            .retryOnBecomesReachable((), reachabilityService: reachabilityService)
            .subscribe(onNext: { () in
                handler()
            })
            .disposed(by: disposeBag)
        return disposeBag
    }
}
