//
//  SetPaymentCardViewModel.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

class SetPaymentCardViewModel: ViewModel {
    
    private let sessionProvider: ProviderProtocol
    private var paymentMethods: [PaymentMethod] = []
    
    init(sessionProvider: ProviderProtocol = URLSessionProvider()) {
        self.sessionProvider = sessionProvider
    }
    
    var totalPaymentMethods: Int {
        return paymentMethods.count
    }
    
    func title(for indexPath: IndexPath) -> String {
        return paymentMethods[indexPath.row].name
    }
    
    var paymentMethodsDidLoad: (() -> Void)?
    
}

// MARK: - Networking methods

extension SetPaymentCardViewModel {
    
    func getPaymentMethods() {
        let filter = PaymentCardFilter()
        sessionProvider.request(type: [PaymentMethod].self, service: PaymentCardService.methods(filter)) { [weak self] response in
            switch response {
            case .failure(let error): print(error)
            case .success(let paymentMethods):
                self?.paymentMethods = paymentMethods.filter { $0.statusType == .active }
                self?.paymentMethodsDidLoad?()
            }
        }
    }
    
}
