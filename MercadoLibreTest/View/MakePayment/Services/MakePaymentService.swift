//
//  InstallmentsService.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

enum MakePaymentService: ServiceProtocol {
    
    case installments(InstallmentsFilter)
    case banks(BankFilter)
    case paymentMethods(PaymentCardFilter)
    
    var path: String? {
        switch self {
        case .installments: return APIEndpoints.Installments.payment
        case .banks: return APIEndpoints.Banks.banks
        case .paymentMethods: return APIEndpoints.Payment.methods
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
        case .installments(let filter): return .requestParameters(filter.parameters())
        case .banks(let filter): return .requestParameters(filter.parameters())
        case .paymentMethods(let filter): return .requestParameters(filter.parameters())
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
    
}
