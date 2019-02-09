//
//  UIViewControllerExtensions.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

extension UIViewController {

    func addGestureToHideKeyboad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
    
}
