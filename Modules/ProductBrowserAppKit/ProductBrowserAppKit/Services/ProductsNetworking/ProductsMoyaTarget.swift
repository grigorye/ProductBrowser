//
//  MoyaTarget.swift
//  OpenProductsMapKit/NetworkingImp/Moya
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Moya

enum ProductsMoyaTarget : Moya.TargetType {
    
    case products
    
    // MARK: -
    
    var baseURL: URL { return URL(string: "https://gist.githubusercontent.com")!}
    
    var path: String {
        switch self {
        case .products:
            return "anonymous/a3b3e50413fff111505a/raw/0522419f508e7ea506a8856586dce11a5664e9df/products.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .products:
            return .get
        }
    }
    
    var sampleData: Data {
        let bundle: Bundle = .current
        let dataURL: URL = {
            switch self {
            case .products:
                return bundle.url(forResource: "ProductsNetworkingResponseSample", withExtension: "json")!
            }
        }()
        return try! Data(contentsOf: dataURL)
    }
    
    var task: Moya.Task {
        switch self {
        case .products:
            return .requestCompositeData(bodyData: Data(), urlParameters: [:])
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
