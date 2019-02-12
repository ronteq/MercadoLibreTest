//
//  PaymentTableViewCell.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell, ViewModelSetupCellProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: PaymentCellViewModel? {
        didSet {
            setupUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(withViewModel viewModel: PaymentCellViewModel?) {
        self.viewModel = viewModel
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
    }
    
}
