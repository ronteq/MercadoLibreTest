//
//  APIEndpoints.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

struct APIEndpoints {
    
    struct Payment {
        static let methods = "payment_methods"
    }
    
    struct Banks {
        static let banks = "payment_methods/card_issuers"
    }
    
    struct Installments {
        static let payment = "payment_methods/installments"
    }
    
}
