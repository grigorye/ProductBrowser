//
//  MoyaNetworkingTests.swift
//  OpenProductsMapKit/NetworkingImp/Moya
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import ProductBrowserAppKit
import Quick
import Nimble
import Moya

class MoyaProductsNetworkingImp_QueryProducts_T : QuickSpec {
    override func spec() {
        context("with good network") {
            var networking: ProductsNetworking!
            beforeEach {
                let moyaProvider = MoyaProductsNetworkingImp.MoyaProvider(stubClosure: MoyaProvider.immediatelyStub)
                networking = MoyaProductsNetworkingImp(moyaProvider: moyaProvider)
            }
            it("should succeed") {
                var productsRequestResult: ProductsNetworkingQueryResult!
                networking.queryProducts(completion: { (result) in
                    productsRequestResult = result
                })
                expect(productsRequestResult).notTo(beNil())
                var response: ProductsNetworkingResponse!
                expect { response = try productsRequestResult.dematerialize() }.notTo(throwError())
                expect(response?.first?.name) != ""
            }
        }
    }
}

class MoyaProductsNetworkingImp_QueryProducts_ET : QuickSpec {
    override func spec() {
        context("with bad network") {
            let sampleResponseClosuresWithFailureContext: [(String, Endpoint.SampleResponseClosure)] = [
                ("http 404", { .networkResponse(404, Data()) }),
                ("user cancelled", { .networkError(NSError(domain: NSCocoaErrorDomain, code: NSUserCancelledError)) }),
                ("timed out", { .networkError(NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut)) })
            ]
            for (failureContext, sampleResponseClosure) in sampleResponseClosuresWithFailureContext {
                context("due \(failureContext)") {
                    var networking: ProductsNetworking!
                    beforeEach {
                        let endpointClosure = { (target: ProductsMoyaTarget) -> Endpoint in
                            let url = URL(target: target).absoluteString
                            return Endpoint(url: url, sampleResponseClosure: sampleResponseClosure, method: target.method, task: target.task, httpHeaderFields: target.headers)
                        }
                        let moyaProvider = MoyaProductsNetworkingImp.MoyaProvider(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
                        networking = MoyaProductsNetworkingImp(moyaProvider: moyaProvider)
                    }
                    it("should error") {
                        var productsQueryResult: ProductsNetworkingQueryResult!
                        networking.queryProducts(completion: { (result) in
                            productsQueryResult = result
                        })
                        expect(productsQueryResult).notTo(beNil())
                        expect { try productsQueryResult.dematerialize() }.to(throwError())
                    }
                }
            }
        }
    }
}
