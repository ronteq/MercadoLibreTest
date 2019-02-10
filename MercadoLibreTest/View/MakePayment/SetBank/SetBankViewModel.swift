//
//  SetBankViewModel.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

protocol SetBankViewModelDelegate: class {
    func setBankViewModelNextDidPressed(_ setBankViewModel: SetBankViewModel, with payment: Payment)
}

class SetBankViewModel: ViewModel {
    
    private let sessionProvider: ProviderProtocol
    private let payment: Payment
    private var banks: [Bank] = []
    weak var delegate: SetBankViewModelDelegate?
    
    init(sessionProvider: ProviderProtocol = URLSessionProvider(), payment: Payment) {
        self.sessionProvider = sessionProvider
        self.payment = payment
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
    var banksDidFail: ((String) -> Void)?
    
}

// MARK: - Helper methods

extension SetBankViewModel {
    
    func nextButtonPressed() {
        guard let selectedBank = selectedBank else { return }
        payment.bank = selectedBank
        delegate?.setBankViewModelNextDidPressed(self, with: payment)
    }
    
}

// MARK: - Networking methods

extension SetBankViewModel {
    
    func getBanks() {
        if InternetConnection.isOn() {
            guard let paymentMethodId = payment.paymentMethod?.id else { return }
            var filter = BankFilter()
            filter.paymentMethod = paymentMethodId
            sessionProvider.request(type: [Bank].self, service: BankService.banks(filter)) { [weak self] response in
                switch response {
                case .failure: self?.banksDidFail?("server_error".localized())
                case .success(let banks):
                    self?.banks = banks
                    self?.banksDidLoad?()
                }
            }
        } else {
            banksDidFail?("no_internet".localized())
        }
    }
    
}
