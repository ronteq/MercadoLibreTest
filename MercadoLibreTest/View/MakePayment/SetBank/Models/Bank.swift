//
//  Bank.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

struct Bank: Decodable {
    var id: String
    var name: String
    var imageUrl: String
    var isSelected: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "secure_thumbnail"
    }
}
