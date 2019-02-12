//
//  PaymentRepository.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

typealias GetPaymentsResult = ((Response<[Payment]>) -> Void)?
typealias SavePaymentResult = ((Response<CDPayment>) -> Void)?

protocol PaymentRepository {
    func getPayments(result: GetPaymentsResult)
    func savePayment(with payment: Payment, result: SavePaymentResult)
}
