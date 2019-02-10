//
//  SetBankViewModel.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

protocol SetBankViewModelDelegate: class {
    func setBankViewModelNextDidPressed(_ setBankViewModel: SetBankViewModel)
}

class SetBankViewModel: ViewModel {
    
    private let sessionProvider: ProviderProtocol
    private let selectedPaymentMethod: PaymentMethod
    private var banks: [Bank] = []
    weak var delegate: SetBankViewModelDelegate?
    
    init(sessionProvider: ProviderProtocol = URLSessionProvider(), selectedPaymentMethod: PaymentMethod) {
        self.sessionProvider = sessionProvider
        self.selectedPaymentMethod = selectedPaymentMethod
    }
    
    var selectedBank: Bank? {
        return banks.first(where: { $0.isSelected })
    }
    
    var totalBanks: Int {
        return banks.count
    }
    
    func title(for indexPath: IndexPath) -> String {
        return banks[indexPath.row].name
    }
    
    func imageUrl(for indexPath: IndexPath) -> URL? {
        return URL(string: banks[indexPath.row].imageUrl)
    }
    
    func shouldSelectBank(at indexPath: IndexPath, select: Bool) {
        banks[indexPath.row].isSelected = select
        let shouldEnableButton = banks.first(where: { $0.isSelected }) != nil
        nextButtonShouldEnable?(shouldEnableButton)
    }
    
    var banksDidLoad: (() -> Void)?
    var nextButtonShouldEnable: ((Bool) -> Void)?
    
}

// MARK: - Helper methods

extension SetBankViewModel {
    
    func nextButtonPressed() {
        delegate?.setBankViewModelNextDidPressed(self)
    }
    
}

// MARK: - Networking methods

extension SetBankViewModel {
    
    func getBanks() {
        var filter = BankFilter()
        filter.paymentMethod = selectedPaymentMethod.id
        sessionProvider.request(type: [Bank].self, service: BankService.banks(filter)) { [weak self] response in
            switch response {
            case .failure(let error): print(error)
            case .success(let banks):
                self?.banks = banks
                self?.banksDidLoad?()
            }
        }
    }
    
}
