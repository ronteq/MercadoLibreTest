//
//  AppCoordinator.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
    }
    
}

// MARK: - Initialization

extension AppCoordinator {
    
    func start() {
        showMoviesController()
    }
    
    private func showMoviesController() {
        let amountCoordinator = AmountCoordinator()
        amountCoordinator.start()
        addChildCoordinator(childCoordinator: amountCoordinator)
        window.rootViewController = amountCoordinator.rootViewController
        window.makeKeyAndVisible()
    }
    
}
