//
//  NetworkResponse.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError {
    case unknown(String)
    case noData
}
