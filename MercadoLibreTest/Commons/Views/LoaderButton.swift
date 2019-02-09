//
//  LoaderButton.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

class LoaderButton: UIButton {
    
    private let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    var title: String?
    var shouldEnable: Bool = true {
        didSet {
            alpha = shouldEnable ? 1.0 : 0.5
            isEnabled = shouldEnable
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupLoader()
    }
    
    private func setup() {
        backgroundColor = .orange
        layer.cornerRadius = 10
        clipsToBounds = true
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupLoader() {
        addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func startLoader() {
        title = titleLabel?.text
        loader.startAnimating()
        isEnabled = false
        setTitle("", for: .normal)
    }
    
    func stopLoader() {
        loader.stopAnimating()
        isEnabled = true
        setTitle(title, for: .normal)
    }
    
}
