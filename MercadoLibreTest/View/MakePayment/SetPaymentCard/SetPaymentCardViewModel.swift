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
    
    init(sessionProvider: ProviderProtocol = URLSessionProvider()) {
        self.sessionProvider = sessionProvider
    }
    
}

// MARK: - Networking methods

extension SetPaymentCardViewModel {
    
    func getPaymentMethods() {
        let filter = PaymentCardFilter()
        sessionProvider.request(type: [PaymentMethod].self, service: PaymentCardService.methods(filter)) { [weak self] response in
            switch response {
            case .failure(let error): print(error)
            case .success(let paymentMethods): print(paymentMethods)
            }
        }
    }
    
}
