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
        label.text = "label_amount_description".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "amount_placeholder".localized()
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(amountChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var reasonTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "reason_placeholder".localized()
        textField.keyboardType = .default
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var nextButton: LoaderButton = {
        let button = LoaderButton(type: .system)
        button.setTitle("next".localized(), for: .normal)
        button.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        button.shouldEnable = false
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
    
}

// MARK: - Life cycle

extension AmountViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupViewModel()
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
        setupReasonTextField()
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
    
    private func setupReasonTextField() {
        view.addSubview(reasonTextField)
        reasonTextField.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 16).isActive = true
        reasonTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        reasonTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        reasonTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
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
    
    private func setupViewModel() {
        viewModel.nextButtonShouldEnable = { [weak self] shouldEnable in
            self?.nextButton.shouldEnable = shouldEnable
        }
    }
    
}

// MARK: - Handler methods

extension AmountViewController {
    
    @objc
    func cancelPayment() {
        viewModel.cancelPayment()
    }
    
    @objc
    private func amountChange() {
        guard let amount = amountTextField.text,
            !amount.isEmpty else {
                viewModel.setAmount(to: 0)
                return
        }
        
        viewModel.setAmount(to: Int(amount) ?? 0)
    }
    
    @objc
    private func nextPressed() {
        viewModel.nextButtonPressed(with: reasonTextField.text)
    }
    
}
