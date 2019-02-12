//
//  SetPaymentCardViewModel.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

protocol SetPaymentCardViewModelDelegate: class {
    func setPaymentCardViewModelNextDidPressed(_ setPaymentCardViewModel: SetPaymentCardViewModel, with payment: Payment)
}

class SetPaymentCardViewModel: ViewModel {
    
    private let sessionProvider: ProviderProtocol
    private let payment: Payment
    private var paymentMethods: [PaymentMethod] = []
    weak var delegate: SetPaymentCardViewModelDelegate?
    
    init(sessionProvider: ProviderProtocol = URLSessionProvider(), payment: Payment) {
        self.sessionProvider = sessionProvider
        self.payment = payment
    }
    
    var selectedPaymentMethod: PaymentMethod? {
        return paymentMethods.first(where: { $0.isSelected })
    }
    
    var totalPaymentMethods: Int {
        return paymentMethods.count
    }
    
    func title(for indexPath: IndexPath) -> String {
        return paymentMethods[indexPath.row].name
    }
    
    func imageUrl(for indexPath: IndexPath) -> URL? {
        return URL(string: paymentMethods[indexPath.row].imageUrl)
    }
    
    func shouldSelectPaymentMethod(at indexPath: IndexPath, select: Bool) {
        paymentMethods[indexPath.row].isSelected = select
        let shouldEnableButton = paymentMethods.first(where: { $0.isSelected }) != nil
        nextButtonShouldEnable?(shouldEnableButton)
    }
    
    var paymentMethodsDidLoad: (() -> Void)?
    var paymentMethodsDidFail: ((String) -> Void)?
    var nextButtonShouldEnable: ((Bool) -> Void)?
    
}

// MARK: - Helper methods

extension SetPaymentCardViewModel {
    
    func nextButtonPressed() {
        guard let selectedPaymentMethod = selectedPaymentMethod else { return }
        payment.paymentMethod = selectedPaymentMethod
        delegate?.setPaymentCardViewModelNextDidPressed(self, with: payment)
    }
    
}

// MARK: - Networking methods

extension SetPaymentCardViewModel {
    
    func getPaymentMethods() {
        if InternetConnection.isOn() {
            let filter = PaymentCardFilter()
            sessionProvider.request(type: [PaymentMethod].self, service: MakePaymentService.paymentMethods(filter)) { [weak self] response in
                switch response {
                case .failure(let responseError): self?.handleError(responseError: responseError)
                case .success(let paymentMethods):
                    self?.paymentMethods = paymentMethods.filter { $0.statusType == .active }
                    self?.paymentMethodsDidLoad?()
                }
            }
        } else {
            paymentMethodsDidFail?("no_internet".localized())
        }
    }
    
    private func handleError(responseError: ResponseError) {
        switch responseError {
        case .noData: paymentMethodsDidFail?("server_error".localized())
        case .unknown(let message): paymentMethodsDidFail?(message)
        }
    }
    
}
