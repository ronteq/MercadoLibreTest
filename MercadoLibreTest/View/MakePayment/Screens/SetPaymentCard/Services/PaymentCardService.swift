//
//  PaymentCardService.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

enum PaymentCardService: ServiceProtocol {
    
    case methods(PaymentCardFilter)
    
    var path: String? {
        switch self {
        case .methods: return APIEndpoints.Payment.methods
        }
    }
    
    var id: String? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case .methods(let filter): return .requestParameters(filter.parameters())
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
    
}
