//
//  Loader.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

enum LoaderStates {
    case loading
    case done
}

class Loader: UIView {
    
    var state: LoaderStates = .done {
        didSet {
            switch state {
            case .done: setupDoneStyle()
            case .loading: setupLoadingStyle()
            }
        }
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        setupLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupStyle() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLoader() {
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupLoadingStyle() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.alpha = 1.0
            }, completion: { [weak self] _ in
                self?.activityIndicator.startAnimating()
        })
    }
    
    private func setupDoneStyle() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.alpha = 0.0
            }, completion: { [weak self] _ in
                self?.activityIndicator.stopAnimating()
        })
    }
    
}
