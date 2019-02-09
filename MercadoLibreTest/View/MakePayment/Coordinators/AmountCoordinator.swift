//
//  AmountCoordinator.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class MakePaymentCoordinator: Coordinator, RootViewCoordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigation = UINavigationController()
        return navigation
    }()
    
}

// MARK: - Initialization

extension MakePaymentCoordinator {
    
    func start() {
        let amountController = AmountViewController()
        navigationController.viewControllers = [amountController]
    }
    
}
