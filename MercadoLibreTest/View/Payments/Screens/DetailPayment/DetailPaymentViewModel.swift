//
//  DetailPaymentViewModel.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

enum DetailPaymentCategory: String {
    case general = "General"
    case bank = "Información Banco"
    case paymentMethod = "Información Método de Pago"
}

protocol DetailPaymentItem {
    var payment: Payment { get }
    var category: DetailPaymentCategory { get }
    var sectionTitle: String { get }
    var numberOfRows: Int { get }
}

extension DetailPaymentItem {
    
    var numberOfRows: Int {
        return 1
    }
    
}

class DetailPaymentViewModel: ViewModel {
    
    private var items: [DetailPaymentItem] = []
    
    init(payment: Payment) {
        let generalItem = DetailGeneralItem(payment: payment)
        let paymentItem = DetailPaymentMethodItem(payment: payment)
        let bankItem = DetailBankItem(payment: payment)
        items.append(contentsOf: [generalItem, paymentItem, bankItem])
    }
    
    var numberOfSections: Int {
        return items.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return items[section].numberOfRows
    }
    
    func item(in section: Int) -> DetailPaymentItem {
        return items[section]
    }
    
    func title(in section: Int) -> String {
        return items[section].sectionTitle
    }
    
}
