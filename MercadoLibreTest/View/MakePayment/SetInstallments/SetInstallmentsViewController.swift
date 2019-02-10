//
//  SetInstallmentsViewController.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class SetInstallmentsViewController: UIViewController, Alertable {
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "label_description".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private let installmentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "1"
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customOrange
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 1
        stepper.isContinuous = true
        stepper.tintColor = .customOrange
        stepper.addTarget(self, action: #selector(setInstallments), for: .valueChanged)
        return stepper
    }()
    
    private lazy var nextButton: LoaderButton = {
        let button = LoaderButton(type: .system)
        button.setTitle("make_payment".localized(), for: .normal)
        button.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: SetInstallmentsViewModel
    
    init(viewModel: SetInstallmentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

// MARK: - Life cycle

extension SetInstallmentsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupViewModel()
    }
    
}

// MARK: - Initial setup

extension SetInstallmentsViewController {
    
    private func initialSetup() {
        view.backgroundColor = .customGray
        title = "set_installments_title".localized()
        setupDescriptionLabel()
        setupInstallmentsLabel()
        setupErrorLabel()
        setupNextButton()
        addGestureToHideKeyboad()
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
    
    private func setupInstallmentsLabel() {
        let stackView = UIStackView(arrangedSubviews: [installmentsLabel, stepper])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .trailing
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.topAnchor.constraint(equalTo: installmentsLabel.bottomAnchor, constant: 24).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
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
        viewModel.installmentsDidChange = { [weak self] in
            guard let self = self else { return }
            self.installmentsLabel.text = "\(self.viewModel.installments)"
        }
        
        viewModel.recommendedMessageDidLoad = { [weak self] message in
            DispatchQueue.main.async {
                self?.nextButton.stopLoader()
                self?.errorLabel.text = ""
                self?.createAlert(message: message) { _ in
                    self?.viewModel.makePayment()
                }
            }
        }
        
        viewModel.noInstallmentsAvailable = { [weak self] message in
            DispatchQueue.main.async {
                self?.nextButton.stopLoader()
                self?.errorLabel.text = message
            }
        }
    }
    
}

// MARK: - Handler methods

extension SetInstallmentsViewController {
    
    @objc
    private func setInstallments() {
        let value = Int(stepper.value)
        viewModel.setInstallments(to: value)
    }
    
    @objc
    private func nextPressed() {
        nextButton.startLoader()
        viewModel.getRecommendedInstallments()
    }
    
}
