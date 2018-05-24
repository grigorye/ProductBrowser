//
//  ProductsNetworkingResponse.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 23/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

typealias ProductsNetworkingResponse = [NetworkingProduct]

struct NetworkingProduct : Codable {
    
    let name: String
    let description: String
    let items_remaining: Int?
    let category: String
    let image_url: String
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let description = try container.decode(String.self, forKey: .description)
        let category = try container.decode(String.self, forKey: .category)
        let image_url = try container.decode(String.self, forKey: .image_url)
        let items_remaining: Int? = try {
            if let asString = try? container.decode(String.self, forKey: .items_remaining) {
                return Int(asString)!
            }

            return try container.decodeIfPresent(Int.self, forKey: .items_remaining)
            }()

        self.name = name
        self.description = description
        self.items_remaining = items_remaining
        self.category = category
        self.image_url = image_url
    }
}
