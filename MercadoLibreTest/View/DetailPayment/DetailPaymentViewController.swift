//
//  DetailPaymentViewController.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class DetailPaymentViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .customGray
        tv.register(UINib(nibName: DetailGeneralTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DetailGeneralTableViewCell.identifier)
        tv.register(UINib(nibName: DefaultTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DefaultTableViewCell.identifier)
        return tv
    }()
    
    private let viewModel: DetailPaymentViewModel
    
    init(viewModel: DetailPaymentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

// MARK: - Life cycle

extension DetailPaymentViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
}

// MARK: - Initial setup

extension DetailPaymentViewController {
    
    private func initialSetup() {
        title = "set_detail_payment_title".localized()
        view.backgroundColor = .customGray
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.estimatedRowHeight = 200
    }
    
}

// MARK: - UITableViewDelegate

extension DetailPaymentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = viewModel.item(in: indexPath.section)
        switch item.category {
        case .general: return UITableView.automaticDimension
        default: return 100
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.title(in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}

// MARK: - UITableViewDataSource

extension DetailPaymentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.item(in: indexPath.section)
        return setupCell(with: item, at: indexPath)
    }
    
    private func setupCell(with item: DetailPaymentItem, at indexPath: IndexPath) -> UITableViewCell {
        switch item.category {
        case .general:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailGeneralTableViewCell.identifier, for: indexPath) as? DetailGeneralTableViewCell else { return UITableViewCell() }
            cell.item = item
            return cell
            
        case .paymentMethod:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell,
                let item = item as? DetailPaymentMethodItem else { return UITableViewCell() }
            cell.titleLabel.text = item.paymentMethod
            cell.contentImageView.image = #imageLiteral(resourceName: "card")
            return cell
            
        case .bank:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell,
                let item = item as? DetailBankItem else { return UITableViewCell() }
            cell.titleLabel.text = item.bank
            cell.contentImageView.image = #imageLiteral(resourceName: "bank")
            return cell
        }
    }
    
}
