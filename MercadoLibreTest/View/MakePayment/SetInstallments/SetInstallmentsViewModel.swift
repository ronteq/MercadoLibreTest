//
//  SetInstallmentsViewModel.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

protocol SetInstallmentsViewModelDelegate: class {
    func setInstallmentsViewModelNextDidPressed(_ setInstallmentsViewModel: SetInstallmentsViewModel)
}

class SetInstallmentsViewModel: ViewModel {
    
    private let sessionProvider: ProviderProtocol
    private let payment: Payment
    private(set) var installments: Int = 1 {
        didSet {
            installmentsDidChange?()
        }
    }
    
    weak var delegate: SetInstallmentsViewModelDelegate?
    
    init(sessionProvider: ProviderProtocol = URLSessionProvider(), payment: Payment) {
        self.sessionProvider = sessionProvider
        self.payment = payment
    }
    
    var installmentsDidChange: (() -> Void)?
    var recommendedMessageDidLoad: ((String) -> Void)?
    
}

// MARK: - Networking methods

extension SetInstallmentsViewModel {
    
    func getRecommendedInstallments() {
        guard let paymentMethodId = payment.paymentMethod?.id,
            let bankId = payment.bank?.id else { return }
        var filter = InstallmentsFilter()
        filter.amount = payment.amount
        filter.bank = bankId
        filter.paymentMethod = paymentMethodId
        
        sessionProvider.request(type: [PaymentResponse].self, service: InstallmentsService.payment(filter)) { [weak self] response in
            switch response {
            case .failure(let error): print(error)
            case .success(let paymentResponses):
                guard let payer = paymentResponses.first?.payers.first(where: { $0.installments == self?.installments }) else {
                    // show error
                    return
                }
                
                self?.recommendedMessageDidLoad?(payer.recommendedMessage)
            }
        }
    }
    
}

// MARK: - Helper methods

extension SetInstallmentsViewModel {
    
    func setInstallments(to value: Int) {
        installments = value
    }
    
    func makePayment() {
        // guardar en core data
        // mandar notificacion
        // delegate?.setInstallmentsViewModelNextDidPressed(self)
    }
    
}
