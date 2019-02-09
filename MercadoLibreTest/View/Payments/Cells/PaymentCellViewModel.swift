//
//  PaymentCellViewModel.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

class PaymentCellViewModel: ViewModel {
    
    private let payment: Payment
    
    init(payment: Payment) {
        self.payment = payment
    }
    
    var title: String {
        return payment.title
    }
    
}
