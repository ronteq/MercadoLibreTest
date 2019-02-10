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
        paymentsViewModel.delegate = self
        let paymentsController = PaymentsViewController(viewModel: paymentsViewModel)
        navigationController.viewControllers = [paymentsController]
    }
    
    func showMakePaymentCoordinator() {
        let makePaymentCoordinator = MakePaymentCoordinator()
        makePaymentCoordinator.start()
        makePaymentCoordinator.delegate = self
        addChildCoordinator(childCoordinator: makePaymentCoordinator)
        rootViewController.present(makePaymentCoordinator.rootViewController, animated: true, completion: nil)
    }
    
    func showDetailPaymentController(with payment: Payment) {
        let detailViewModel = DetailPaymentViewModel(payment: payment)
        let detailController = DetailPaymentViewController(viewModel: detailViewModel)
        navigationController.pushViewController(detailController, animated: true)
    }
    
}

// MARK: - PaymentsViewModelDelegate

extension PaymentsCoordinator: PaymentsViewModelDelegate {
    
    func paymentsViewModelDidPressedAddButton(_ paymentsViewModel: PaymentsViewModel) {
        showMakePaymentCoordinator()
    }
    
    func paymentsViewModelDidPressedPayment(_ paymentsViewModel: PaymentsViewModel, payment: Payment) {
        showDetailPaymentController(with: payment)
    }
    
}

// MARK: - MakePaymentCoordinatorDelegate

extension PaymentsCoordinator: MakePaymentCoordinatorDelegate {
    
    func makePaymentCoordinatorDidFinish(_ makePaymentCoordinator: MakePaymentCoordinator) {
        makePaymentCoordinator.rootViewController.dismiss(animated: true, completion: nil)
        removeChildCoordinator(childCoordinator: makePaymentCoordinator)
    }
    
}
