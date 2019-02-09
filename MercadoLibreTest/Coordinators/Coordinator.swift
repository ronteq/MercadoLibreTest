//
//  Coordinator.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
    
    func addChildCoordinator(childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }
    
    func removeChildCoordinator(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
    
}
