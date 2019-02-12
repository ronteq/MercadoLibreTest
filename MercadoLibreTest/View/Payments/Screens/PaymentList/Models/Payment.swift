//
//  Payment.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

class Payment {
    var title = ""
    var message = ""
    var amount = 0
    var installments = 0
    var paymentMethod: PaymentMethod?
    var bank: Bank?
    var createdAt = Date()
    
    convenience init(with cdPayment: CDPayment) {
        self.init()
        self.title = cdPayment.title ?? ""
        self.message = cdPayment.message ?? ""
        self.amount = Int(cdPayment.amount)
        self.installments = Int(cdPayment.installments)
        self.paymentMethod = PaymentMethod(with: cdPayment.paymentMethod ?? "")
        self.bank = Bank(with: cdPayment.bank ?? "")
        self.createdAt = cdPayment.createdAt as Date? ?? Date()
    }
    
}

extension Payment {
    
    static func with(title: String = "test", message: String = "", amount: Int = 0, installments: Int = 0, paymentMethod: PaymentMethod? = nil, bank: Bank? = nil, createdAt: Date = Date()) -> Payment {
        let payment = Payment()
        payment.title = title
        payment.message = message
        payment.amount = amount
        payment.installments = installments
        payment.paymentMethod = paymentMethod
        payment.bank = bank
        payment.createdAt = createdAt
        return payment
    }
    
}