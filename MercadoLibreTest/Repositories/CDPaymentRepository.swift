//
//  CDPaymentRepository.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation
import CoreData

class CDPaymentRepository: PaymentRepository {
    
    private let viewContext = CoreDataStack.shared.viewContext
    
    func getPayments(result: GetPaymentsResult) {
        let request: NSFetchRequest<CDPayment> = CDPayment.fetchRequest()
        do {
            let cdPayments = try viewContext.fetch(request)
            let payments = cdPayments.map { Payment(with: $0) }
            result?(.success(payments))
        } catch {
            result?(.failure(.unknown("Error")))
        }
    }
    
    func savePayment(with payment: Payment, result: SavePaymentResult) {
        let cdPayment = CDPayment(context: viewContext)
        cdPayment.title = payment.title
        cdPayment.amount = Double(payment.amount)
        cdPayment.installments = Double(payment.installments)
        cdPayment.paymentMethod = payment.paymentMethod?.name
        cdPayment.bank = payment.bank?.name
        cdPayment.createdAt = payment.createdAt as NSDate
        
        do {
            try viewContext.save()
            result?(.success(cdPayment))
        } catch let err {
            result?(.failure(.unknown(err.localizedDescription)))
        }
    }
    
}
