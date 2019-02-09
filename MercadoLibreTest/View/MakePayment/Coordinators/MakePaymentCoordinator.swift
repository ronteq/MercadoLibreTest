//
//  MakePaymentCoordinator.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

protocol MakePaymentCoordinatorDelegate: class {
    func makePaymentCoordinatorDidFinish(_ makePaymentCoordinator: MakePaymentCoordinator)
}

class MakePaymentCoordinator: Coordinator, RootViewCoordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigation = UINavigationController()
        return navigation
    }()
    
    weak var delegate: MakePaymentCoordinatorDelegate?
    
    deinit {
        print("MakePaymentCoordinator deleted")
    }
    
}

// MARK: - Initialization

extension MakePaymentCoordinator {
    
    func start() {
        let amountViewModel = AmountViewModel()
        amountViewModel.delegate = self
        let amountController = AmountViewController(viewModel: amountViewModel)
        navigationController.viewControllers = [amountController]
    }
    
}

// MARK: - AmountViewModelDelegate

extension MakePaymentCoordinator: AmountViewModelDelegate {
    
    func amountViewModelDidFinish(_ amountViewModel: AmountViewModel) {
        delegate?.makePaymentCoordinatorDidFinish(self)
    }
    
}
