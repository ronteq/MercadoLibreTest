//
//  BankService.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

enum BankService: ServiceProtocol {
    
    case banks(BankFilter)
    
    var path: String? {
        switch self {
        case .banks: return APIEndpoints.Banks.banks
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
        case .banks(let filter): return .requestParameters(filter.parameters())
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
    
}
