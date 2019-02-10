//
//  PaymentMethod.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

enum StatusType: String {
    case active
    case testing
}

struct PaymentMethod: Decodable {
    var id: String
    var name: String
    var status: String
    var imageUrl: String
    
    var statusType: StatusType {
        return StatusType(rawValue: status) ?? .testing
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case imageUrl = "secure_thumbnail"
    }
}
