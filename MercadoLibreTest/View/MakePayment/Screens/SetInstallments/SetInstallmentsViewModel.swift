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
    private let paymentRepository: PaymentRepository
    private let payment: Payment
    private(set) var installments: Int = 1 {
        didSet {
            payment.installments = installments
            installmentsDidChange?()
        }
    }
    
    weak var delegate: SetInstallmentsViewModelDelegate?
    
    init(sessionProvider: ProviderProtocol = URLSessionProvider(), paymentRepository: PaymentRepository = CDPaymentRepository(), payment: Payment) {
        self.sessionProvider = sessionProvider
        self.paymentRepository = paymentRepository
        self.payment = payment
    }
    
    var installmentsDidChange: (() -> Void)?
    var noInstallmentsAvailable: ((String) -> Void)?
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
        
        sessionProvider.request(type: [PaymentResponse].self, service: MakePaymentService.installments(filter)) { [weak self] response in
            switch response {
            case .failure(let responseError): self?.handleError(responseError: responseError)
            case .success(let paymentResponses):
                guard let payer = paymentResponses.first?.payers.first(where: { $0.installments == self?.installments }) else {
                    self?.noInstallmentsAvailable?("installments_error".localized())
                    return
                }
                
                self?.payment.message = payer.recommendedMessage
                self?.recommendedMessageDidLoad?(payer.recommendedMessage)
            }
        }
    }
    
    private func handleError(responseError: ResponseError) {
        switch responseError {
        case .noData: noInstallmentsAvailable?("server_error".localized())
        case .unknown(let message): noInstallmentsAvailable?(message)
        }
    }
    
}

// MARK: - Helper methods

extension SetInstallmentsViewModel {
    
    func setInstallments(to value: Int) {
        installments = value
    }
    
    func makePayment() {
        paymentRepository.savePayment(with: payment) { [weak self] response in
            switch response {
            case .success:
                self?.sendNotificationAndDismiss()
            case .failure(let error): print(error)
            }
        }
    }
    
    private func sendNotificationAndDismiss() {
        NotificationCenter.default.post(name: .paymentDidSave, object: nil)
        delegate?.setInstallmentsViewModelNextDidPressed(self)
    }
    
}
