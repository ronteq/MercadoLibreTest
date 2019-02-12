//
//  SetPaymentCardViewController.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit
import SDWebImage

class SetPaymentCardViewController: UIViewController, CanShowError, Loadable {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .customGray
        tv.register(UINib(nibName: DefaultTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DefaultTableViewCell.identifier)
        return tv
    }()
    
    private lazy var nextButton: LoaderButton = {
        let button = LoaderButton(type: .system)
        button.setTitle("next".localized(), for: .normal)
        button.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        button.shouldEnable = false
        return button
    }()
    
    private let viewModel: SetPaymentCardViewModel
    var errorView: ErrorView?
    var loader = Loader()
    
    init(viewModel: SetPaymentCardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

// MARK: - Life cycle

extension SetPaymentCardViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupViewModel()
    }
    
}

// MARK: - Initial setup

extension SetPaymentCardViewController {
    
    private func initialSetup() {
        view.backgroundColor = .customGray
        title = "set_payment_title".localized()
        setupNextButton()
        setupTableView()
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
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16).isActive = true
    }
    
    private func setupViewModel() {
        viewModel.paymentMethodsDidLoad = { [weak self] in
            DispatchQueue.main.async {
                self?.stopLoader()
                self?.hideError()
                self?.tableView.reloadData()
            }
        }
        
        viewModel.nextButtonShouldEnable = { [weak self] shouldEnable in
            self?.nextButton.shouldEnable = shouldEnable
        }
        
        viewModel.paymentMethodsDidFail = { [weak self] message in
            DispatchQueue.main.async {
                self?.stopLoader()
                self?.handleErrorView(withMessage: message)
            }
        }
        
        viewModel.getPaymentMethods()
        startLoader()
    }
    
}

// MARK: - Handler methods

extension SetPaymentCardViewController {
    
    @objc
    private func nextPressed() {
        viewModel.nextButtonPressed()
    }
    
    private func handleErrorView(withMessage message: String) {
        showError(withMessage: message)
        errorView?.onTryAgainDidPressed = { [weak self] in
            self?.viewModel.getPaymentMethods()
        }
    }
    
}

// MARK: - UITableViewDelegate

extension SetPaymentCardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.shouldSelectPaymentMethod(at: indexPath, select: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.shouldSelectPaymentMethod(at: indexPath, select: false)
    }
    
}

// MARK: - UITableViewDataSource

extension SetPaymentCardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalPaymentMethods
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = viewModel.title(for: indexPath)
        cell.contentImageView.sd_setImage(with: viewModel.imageUrl(for: indexPath)) { (_, error, _, _) in
            if error != nil {
                cell.setDefaultImage(emptyImage: true)
            }
        }
        return cell
    }
    
}
