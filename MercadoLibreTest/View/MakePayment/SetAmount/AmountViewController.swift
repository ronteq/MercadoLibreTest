//
//  AmountViewController.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController {
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "label_description".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "amount_placeholder".localized()
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var nextButton: LoaderButton = {
        let button = LoaderButton(type: .system)
        button.setTitle("next".localized(), for: .normal)
        button.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: AmountViewModel
    
    init(viewModel: AmountViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc
    func cancelPayment() {
        viewModel.cancelPayment()
    }
    
}

// MARK: - Life cycle

extension AmountViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
}

// MARK: - Initial setup

extension AmountViewController {
    
    private func initialSetup() {
        view.backgroundColor = .customGray
        title = "amount_title".localized()
        addCancelButton()
        setupDescriptionLabel()
        setupAmountTextField()
        setupNextButton()
        addGestureToHideKeyboad()
    }
    
    private func addCancelButton() {
        let cancelButton = UIBarButtonItem(title: "cancel".localized(), style: .done, target: self, action: #selector(cancelPayment))
        navigationItem.leftBarButtonItems = [cancelButton]
    }
    
    private func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        
        if #available(iOS 11.0, *) {
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        } else {
            descriptionLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 16).isActive = true
        }
        
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
    }
    
    private func setupAmountTextField() {
        view.addSubview(amountTextField)
        amountTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24).isActive = true
        amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        if #available(iOS 11.0, *) {
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        } else {
            nextButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -16).isActive = true
        }
    }
    
}

// MARK: - Handler methods

extension AmountViewController {
    
    @objc
    private func nextPressed() {
        print("NEXT!")
    }
    
}
