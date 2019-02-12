//
//  DetailGeneralItem.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

class DetailGeneralItem: ViewModel, DetailPaymentItem {
    
    let payment: Payment
    
    init(payment: Payment) {
        self.payment = payment
    }
    
    var category: DetailPaymentCategory {
        return .general
    }
    
    var sectionTitle: String {
        return category.rawValue
    }
    
    var title: String {
        return payment.title
    }
    
    var amount: String {
        return "S/\(payment.amount)"
    }
    
    var installments: String {
        return "\(payment.installments)"
    }
    
    var message: String {
        return "\(payment.message)"
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: payment.createdAt)
    }
    
}
