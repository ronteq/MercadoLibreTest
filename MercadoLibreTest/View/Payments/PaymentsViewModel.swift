//
//  PaymentsViewModel.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

protocol PaymentsViewModelDelegate: class {
    func paymentsViewModelDidPressedAddButton(_ paymentsViewModel: PaymentsViewModel)
}

class PaymentsViewModel: ViewModel {
    
    private var payments: [Payment] = [
        Payment(),
        Payment(),
        Payment(),
        Payment(),
        Payment()
    ]
    
    weak var delegate: PaymentsViewModelDelegate?
    
    var totalPayments: Int {
        return payments.count
    }
    
}

// MARK: - Helper methods

extension PaymentsViewModel {
    
    func cellViewModel(for indexPath: IndexPath) -> PaymentCellViewModel {
        return PaymentCellViewModel(payment: payments[indexPath.row])
    }
    
    func makePayment() {
        delegate?.paymentsViewModelDidPressedAddButton(self)
    }
    
}
