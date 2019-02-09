//
//  AmountViewController.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController {
    
    private let viewModel: AmountViewModel
    
    init(viewModel: AmountViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "amount_title".localized()
        let cancelButton = UIBarButtonItem(title: "cancel".localized(), style: .done, target: self, action: #selector(cancelPayment))
        navigationItem.leftBarButtonItems = [cancelButton]
    }
    
    @objc
    func cancelPayment() {
        viewModel.cancelPayment()
    }
    
}
