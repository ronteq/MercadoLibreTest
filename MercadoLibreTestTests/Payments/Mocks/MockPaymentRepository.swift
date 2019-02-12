//
//  MockPaymentRepository.swift
//  MercadoLibreTestTests
//
//  Created by Daniel Fernandez on 2/11/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class MockPaymentRepository: PaymentRepository {
    
    enum Mode {
        case fill
        case empty
        case error
    }
    
    private let mode: Mode
    private let payments = [Payment.with(title: "payment1"), Payment.with(title: "payment2"), Payment.with(title: "payment3")]
    
    init(mode: Mode) {
        self.mode = mode
    }
    
    func getPayments(result: GetPaymentsResult) {
        switch mode {
        case .fill: result?(.success(payments))
        case .empty: result?(.success([]))
        case .error: result?(.failure(.unknown("Error")))
        }
    }
    
    func savePayment(with payment: Payment, result: SavePaymentResult) {
        
    }
    
}
