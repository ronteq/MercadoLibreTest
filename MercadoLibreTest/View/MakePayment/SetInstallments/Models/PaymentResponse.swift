//
//  PaymentResponse.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

struct PaymentResponse: Decodable {
    var payers: [Payer] = []
    
    private enum CodingKeys: String, CodingKey {
        case payers = "payer_costs"
    }
}

struct Payer: Decodable {
    var installments: Int
    var recommendedMessage: String
    
    private enum CodingKeys: String, CodingKey {
        case installments
        case recommendedMessage = "recommended_message"
    }
}
