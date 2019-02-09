//
//  PaymentsViewModel.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

class PaymentsViewModel: ViewModel {
    
    private var payments: [Payment] = [
        Payment(),
        Payment(),
        Payment(),
        Payment(),
        Payment()
    ]
    
    var totalPayments: Int {
        return payments.count
    }
    
}

// MARK: - Helper methods

extension PaymentsViewModel {
    
    func cellViewModel(for indexPath: IndexPath) -> PaymentCellViewModel {
        return PaymentCellViewModel(payment: payments[indexPath.row])
    }
    
}
