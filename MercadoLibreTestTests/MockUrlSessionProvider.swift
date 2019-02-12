//
//  MockUrlSessionProvider.swift
//  MercadoLibreTestTests
//
//  Created by Daniel Fernandez on 2/11/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class MockUrlSessionProvider: ProviderProtocol {
    
    enum Mode<T> {
        case success(T)
        case empty()
        case fail(String)
    }
    
    private var mode: Any
    
    init<T>(mode: Mode<T>) {
        self.mode = mode
    }
    
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (Response<T>) -> Void) where T: Decodable {
        guard let mode = mode as? Mode<T> else { return }
        
        switch mode {
        case .success (let model): completion(.success(model))
        case .empty: completion(.failure(.noData))
        case .fail(let message): completion(.failure(.unknown(message)))
        }
    }
    
}
