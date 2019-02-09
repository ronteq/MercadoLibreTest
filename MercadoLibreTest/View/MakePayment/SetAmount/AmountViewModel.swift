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
    
    weak var delegate: AmountViewModelDelegate?
    
    func cancelPayment() {
        delegate?.amountViewModelDidFinish(self)
    }
    
}
