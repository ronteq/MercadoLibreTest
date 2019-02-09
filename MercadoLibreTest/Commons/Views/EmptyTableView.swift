//
//  EmptyTableView.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class EmptyTableView: UIView {
    
    let noResultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "no_results".localized()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
        backgroundColor = .customGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupLabel() {
        addSubview(noResultsLabel)
        noResultsLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        noResultsLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        noResultsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        noResultsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
}
