//
//  SetPaymentCardViewController.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class SetPaymentCardViewController: UIViewController {
    
    private let viewModel: SetPaymentCardViewModel
    
    init(viewModel: SetPaymentCardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

// MARK: - Life cycle

extension SetPaymentCardViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
}

// MARK: - Initial setup

extension SetPaymentCardViewController {
    
    private func initialSetup() {
        view.backgroundColor = .customGray
        title = "set_payment_title".localized()
    }
}
