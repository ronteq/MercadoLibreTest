//
//  DetailBankItem.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

class DetailBankItem: ViewModel, DetailPaymentItem {
    
    let payment: Payment
    
    init(payment: Payment) {
        self.payment = payment
    }
    
    var category: DetailPaymentCategory {
        return .bank
    }
    
    var sectionTitle: String {
        return category.rawValue
    }
    
    var bank: String {
        return payment.bank?.name ?? ""
    }
    
}
