//
//  NetworkResponse.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

enum Response<T> {
    case success(T)
    case failure(ResponseError)
}

enum ResponseError {
    case unknown(String)
    case noData
}
