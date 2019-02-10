//
//  PaymentsViewModel.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

protocol PaymentsViewModelDelegate: class {
    func paymentsViewModelDidPressedAddButton(_ paymentsViewModel: PaymentsViewModel)
    func paymentsViewModelDidPressedPayment(_ paymentsViewModel: PaymentsViewModel, payment: Payment)
}

class PaymentsViewModel: ViewModel {
    
    private var payments: [Payment] = []
    private let paymentRepository: PaymentRepository
    weak var delegate: PaymentsViewModelDelegate?
    
    init(paymentRepository: PaymentRepository = CDPaymentRepository()) {
        self.paymentRepository = paymentRepository
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(paymentsDidUpdate), name: .paymentDidSave, object: nil)
        getPayments()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    var totalPayments: Int {
        return payments.count
    }
    
    var paymentsDidLoad: (() -> Void)?
    
}

// MARK: - Helper methods

extension PaymentsViewModel {
    
    func getPayments() {
        paymentRepository.getPayments { [weak self] response in
            switch response {
            case .success(let payments): self?.payments = payments
            case .failure(let error): print(error)
            }
        }
    }
    
    func cellViewModel(for indexPath: IndexPath) -> PaymentCellViewModel {
        return PaymentCellViewModel(payment: payments[indexPath.row])
    }
    
    func makePayment() {
        delegate?.paymentsViewModelDidPressedAddButton(self)
    }
    
    func didSelect(at indexPath: IndexPath) {
        delegate?.paymentsViewModelDidPressedPayment(self, payment: payments[indexPath.row])
    }
    
    @objc
    private func paymentsDidUpdate() {
        getPayments()
        paymentsDidLoad?()
    }
    
}
