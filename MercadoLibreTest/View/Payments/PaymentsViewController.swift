//
//  PaymentsViewController.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class PaymentsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .customGray
        tv.register(UINib(nibName: PaymentTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PaymentTableViewCell.identifier)
        return tv
    }()
    
    private let viewModel: PaymentsViewModel
    lazy var emptyView = EmptyTableView()
    
    init(viewModel: PaymentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

// MARK: - Life cycle

extension PaymentsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupViewModel()
    }
    
}

// MARK: - Initial setup

extension PaymentsViewController {
    
    private func initialSetup() {
        title = "payments_title".localized()
        view.backgroundColor = .customGray
        setupTableView()
        setupAddBarButton()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupAddBarButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPayment))
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    private func setupViewModel() {
        viewModel.paymentsDidLoad = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

// MARK: - Helper methods

extension PaymentsViewController {
    
    @objc
    private func addPayment() {
        viewModel.makePayment()
    }
    
}

// MARK: - UITableViewDelegate

extension PaymentsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

// MARK: - UITableViewDataSource

extension PaymentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalPayments
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PaymentTableViewCell.identifier, for: indexPath) as? PaymentTableViewCell else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.setup(withViewModel: cellViewModel)
        return cell
    }
    
}
