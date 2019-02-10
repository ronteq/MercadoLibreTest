//
//  PaymentCardFilter.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

struct PaymentCardFilter {
    
    func parameters() -> Parameters {
        var param = Parameters()
        
        if let apiKey = Bundle.main.infoDictionary?["MERCADO_PAGO_KEY"] as? String {
            param["public_key"] = apiKey
        }
        
        return param
    }
    
}
