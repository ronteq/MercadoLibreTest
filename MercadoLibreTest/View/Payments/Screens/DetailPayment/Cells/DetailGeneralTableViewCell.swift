//
//  DetailGeneralTableViewCell.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class DetailGeneralTableViewCell: UITableViewCell, CellProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var installmentsLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var item: DetailPaymentItem? {
        didSet {
            setupUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    private func setupUI() {
        guard let item = item as? DetailGeneralItem else { return }
        titleLabel.text = item.title
        dateLabel.text = item.date
        amountLabel.text = item.amount
        installmentsLabel.text = item.installments
        messageLabel.text = item.message
    }
    
}
