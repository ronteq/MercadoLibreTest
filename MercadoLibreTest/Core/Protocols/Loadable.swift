//
//  Loadable.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

protocol Loadable {
    var loader: Loader { get }
    func startLoader()
    func stopLoader()
}

extension Loadable where Self: UIViewController {
    
    func startLoader() {
        view.addSubview(loader)
        loader.widthAnchor.constraint(equalToConstant: 44).isActive = true
        loader.heightAnchor.constraint(equalTo: loader.widthAnchor, multiplier: 1).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.state = .loading
    }
    
    func stopLoader() {
        loader.state = .done
        loader.removeFromSuperview()
    }
    
}
