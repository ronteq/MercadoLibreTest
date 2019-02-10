//
//  ErrorView.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    
    var onTryAgainDidPressed: (() -> Void)?
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tryAgainButton: LoaderButton = {
        let button = LoaderButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "error_button".localized()
        button.addTarget(self, action: #selector(tryAgainButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        alpha = 0.0
        setupViews()
        backgroundColor = .customGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        addSubview(errorLabel)
        addSubview(tryAgainButton)
        
        errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        tryAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tryAgainButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        tryAgainButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 24).isActive = true
    }
    
    @objc
    private func tryAgainButtonPressed() {
        tryAgainButton.startLoader()
        onTryAgainDidPressed?()
    }
    
    func setErrorMessage(_ message: String) {
        errorLabel.text = message
    }
    
}
