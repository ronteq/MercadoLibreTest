//
//  SetPaymentCardViewModel.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

protocol SetPaymentCardViewModelDelegate: class {
    func setPaymentCardViewModelNextDidPressed(_ setPaymentCardViewModel: SetPaymentCardViewModel)
}

class SetPaymentCardViewModel: ViewModel {
    
    private let sessionProvider: ProviderProtocol
    private var paymentMethods: [PaymentMethod] = []
    weak var delegate: SetPaymentCardViewModelDelegate?
    
    init(sessionProvider: ProviderProtocol = URLSessionProvider()) {
        self.sessionProvider = sessionProvider
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
    var nextButtonShouldEnable: ((Bool) -> Void)?
    
}

// MARK: - Helper methods

extension SetPaymentCardViewModel {
    
    func nextButtonPressed() {
        delegate?.setPaymentCardViewModelNextDidPressed(self)
    }
    
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
