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
    var isSelected: Bool = false
    
    init(id: String, name: String, status: String, imageUrl: String, isSelected: Bool) {
        self.id = id
        self.name = name
        self.status = status
        self.imageUrl = imageUrl
        self.isSelected = isSelected
    }
    
    init(with cdPaymentMethod: String) {
        self.id = ""
        self.name = cdPaymentMethod
        self.status = ""
        self.imageUrl = ""
    }
    
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

extension PaymentMethod {
    static func with(id: String = "", name: String = "", status: String = "", imageUrl: String = "", isSelected: Bool = false) -> PaymentMethod {
        return PaymentMethod(id: id, name: name, status: status, imageUrl: imageUrl, isSelected: isSelected)
    }
}
