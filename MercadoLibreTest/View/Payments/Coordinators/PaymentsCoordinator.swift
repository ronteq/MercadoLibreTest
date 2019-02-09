//
//  PaymentsCoordinator.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class PaymentsCoordinator: Coordinator, RootViewCoordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigation = UINavigationController()
        
        if #available(iOS 11, *) {
            navigation.navigationBar.prefersLargeTitles = true
        }
        
        return navigation
    }()
    
}

// MARK: - Initialization

extension PaymentsCoordinator {
    
    func start() {
        let paymentsViewModel = PaymentsViewModel()
        let paymentsController = PaymentsViewController(viewModel: paymentsViewModel)
        navigationController.viewControllers = [paymentsController]
    }
    
}
