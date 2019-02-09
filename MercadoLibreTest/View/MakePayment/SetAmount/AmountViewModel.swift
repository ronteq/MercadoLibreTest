//
//  AmountViewModel.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

protocol AmountViewModelDelegate: class {
    func amountViewModelDidFinish(_ amountViewModel: AmountViewModel)
}

class AmountViewModel: ViewModel {
    
    private var amount: Int = 0
    weak var delegate: AmountViewModelDelegate?
    
    var nextButtonShouldEnable: ((Bool) -> Void)?
}

// MARK: - Helper methods

extension AmountViewModel {
    
    func setAmount(to amount: Int) {
        self.amount = amount
        let shouldEnable = self.amount == 0 ? false : true
        nextButtonShouldEnable?(shouldEnable)
    }
    
    func cancelPayment() {
        delegate?.amountViewModelDidFinish(self)
    }
    
}
