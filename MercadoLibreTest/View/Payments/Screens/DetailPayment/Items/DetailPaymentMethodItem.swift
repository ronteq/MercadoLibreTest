//
//  DetailPaymentMethodItem.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

class DetailPaymentMethodItem: ViewModel, DetailPaymentItem {
    
    let payment: Payment
    
    init(payment: Payment) {
        self.payment = payment
    }
    
    var category: DetailPaymentCategory {
        return .paymentMethod
    }
    
    var sectionTitle: String {
        return category.rawValue
    }
    
    var paymentMethod: String {
        return payment.paymentMethod?.name ?? ""
    }
    
}
