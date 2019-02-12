//
//  InstallmentsService.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

enum InstallmentsService: ServiceProtocol {
    
    case payment(InstallmentsFilter)
    
    var path: String? {
        switch self {
        case .payment: return APIEndpoints.Installments.payment
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
        case .payment(let filter): return .requestParameters(filter.parameters())
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
    
}
