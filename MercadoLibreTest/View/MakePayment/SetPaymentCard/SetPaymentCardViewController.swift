//
//  SetPaymentCardViewController.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class SetPaymentCardViewController: UIViewController {
    
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
    
    private let viewModel: SetPaymentCardViewModel
    
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
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupViewModel() {
        viewModel.paymentMethodsDidLoad = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.getPaymentMethods()
    }
    
}

// MARK: - UITableViewDelegate

extension SetPaymentCardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
        return cell
    }
    
}
