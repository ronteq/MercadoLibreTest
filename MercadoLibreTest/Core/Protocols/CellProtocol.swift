//
//  CellProtocol.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import UIKit

protocol CellProtocol: class {
    static var identifier: String { get }
}

extension CellProtocol where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol ViewModelSetupCellProtocol: CellProtocol {
    associatedtype SetupViewModel: ViewModel
    func setup(withViewModel viewModel: SetupViewModel?)
}
