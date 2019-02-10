//
//  InstallmentsFilter.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

struct InstallmentsFilter {
    
    var paymentMethod = ""
    var bank = ""
    var amount = 0
    
    func parameters() -> Parameters {
        var param = Parameters()
        
        if let apiKey = Bundle.main.infoDictionary?["MERCADO_PAGO_KEY"] as? String {
            param["public_key"] = apiKey
        }
        
        param["payment_method_id"] = paymentMethod
        param["issuer.id"] = bank
        param["amount"] = amount
        
        return param
    }
    
}
