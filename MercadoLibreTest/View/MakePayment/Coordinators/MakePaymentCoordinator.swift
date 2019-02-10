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
    
    func showSetPaymentController(with payment: Payment) {
        let setPaymentViewModel = SetPaymentCardViewModel(payment: payment)
        setPaymentViewModel.delegate = self
        let setPaymentController = SetPaymentCardViewController(viewModel: setPaymentViewModel)
        navigationController.pushViewController(setPaymentController, animated: true)
    }
    
    func showSetBankController(with payment: Payment) {
        let bankViewModel = SetBankViewModel(payment: payment)
        bankViewModel.delegate = self
        let bankController = SetBankViewController(viewModel: bankViewModel)
        navigationController.pushViewController(bankController, animated: true)
    }
    
    func showSetInstallmentsController(with payment: Payment) {
        let setInstallmentsViewModel = SetInstallmentsViewModel(payment: payment)
        setInstallmentsViewModel.delegate = self
        let setInstallmentsController = SetInstallmentsViewController(viewModel: setInstallmentsViewModel)
        navigationController.pushViewController(setInstallmentsController, animated: true)
    }
    
}

// MARK: - AmountViewModelDelegate

extension MakePaymentCoordinator: AmountViewModelDelegate {
    
    func amountViewModelDidCancel(_ amountViewModel: AmountViewModel) {
        delegate?.makePaymentCoordinatorDidFinish(self)
    }
    
    func amountViewModelNextDidPressed(_ amountViewModel: AmountViewModel, with payment: Payment) {
        showSetPaymentController(with: payment)
    }
    
}

// MARK: - SetPaymentCardViewModelDelegate

extension MakePaymentCoordinator: SetPaymentCardViewModelDelegate {
    
    func setPaymentCardViewModelNextDidPressed(_ setPaymentCardViewModel: SetPaymentCardViewModel, with payment: Payment) {
        showSetBankController(with: payment)
    }
    
}

// MARK: - SetBankViewModelDelegate

extension MakePaymentCoordinator: SetBankViewModelDelegate {
    
    func setBankViewModelNextDidPressed(_ setBankViewModel: SetBankViewModel, with payment: Payment) {
        showSetInstallmentsController(with: payment)
    }
    
}

// MARK: - SetInstallmentsViewModelDelegate

extension MakePaymentCoordinator: SetInstallmentsViewModelDelegate {
    
    func setInstallmentsViewModelNextDidPressed(_ setInstallmentsViewModel: SetInstallmentsViewModel) {
        delegate?.makePaymentCoordinatorDidFinish(self)
    }
    
}
