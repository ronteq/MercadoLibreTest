//
//  Payment.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

class Payment {
    var title = "Probando"
    var amount = 0
    var installments = 0
    var paymentMethod: PaymentMethod?
    var bank: Bank?
    var createdAt = Date()
}
