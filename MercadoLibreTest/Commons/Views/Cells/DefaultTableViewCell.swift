//
//  DefaultTableViewCell.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class DefaultTableViewCell: UITableViewCell, CellProtocol {

    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = .customOrange
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.image = nil
        setDefaultImage(emptyImage: false)
    }
    
    func setDefaultImage(emptyImage: Bool) {
        contentImageView.backgroundColor = emptyImage ? .customGray : .clear
        contentImageView.clipsToBounds = emptyImage ? true : false
        contentImageView.layer.cornerRadius = emptyImage ? 10 : 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }
    
}
