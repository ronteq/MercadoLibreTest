//
//  CanShowError.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

protocol CanShowError: class {
    var errorView: ErrorView? { get set }
    func showError(withMessage message: String)
    func hideError()
}

extension CanShowError where Self: UIViewController {
    
    func showError(withMessage message: String) {
        if errorView == nil {
            errorView = ErrorView()
            setupErrorViewConstraints()
        }
        
        errorView?.setErrorMessage(message)
        errorView?.tryAgainButton.stopLoader()
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.errorView?.alpha = 1.0
        }
    }
    
    func hideError() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.errorView?.alpha = 0.0
        }
    }
    
    func setupErrorViewConstraints() {
        guard let errorView = errorView else { return }
        self.view.addSubview(errorView)
        errorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        errorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        errorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
}
