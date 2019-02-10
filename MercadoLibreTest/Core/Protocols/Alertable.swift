//
//  Alertable.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

protocol Alertable {
    func createAlert(message: String, with action: ((UIAlertAction) -> Void)?)
}

extension Alertable where Self: UIViewController {
    
    func createAlert(message: String, with action: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "Mercado Libre", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: action)
        alert.addAction(cancelAction)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
