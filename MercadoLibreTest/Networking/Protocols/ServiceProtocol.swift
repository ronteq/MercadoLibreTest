//
//  ServiceProtocol.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

typealias Headers = [String: String]
typealias Parameters = [String: Any]

protocol ServiceProtocol {
    func baseURL() -> URL
    var path: String? { get }
    var id: String? { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}

extension ServiceProtocol {
    
    func baseURL() -> URL {
        guard let serverURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else { fatalError() }
        return URL(string: serverURL)!
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Task {
    case requestPlain
    case requestParameters(Parameters)
}

enum ParametersEncoding {
    case url
    case json
}
