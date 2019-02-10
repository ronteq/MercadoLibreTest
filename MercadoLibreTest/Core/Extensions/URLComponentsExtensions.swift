//
//  URLComponentsExtensions.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

extension URLComponents {
    
    init(service: ServiceProtocol) {
        var url = service.baseURL()
        
        if let path = service.path {
            url = url.appendingPathComponent(path)
        }
        
        if let id = service.id {
            url = url.appendingPathComponent(id)
        }
        
        self.init(url: url, resolvingAgainstBaseURL: false)!
        
        guard case let .requestParameters(parameters) = service.task,
            service.parametersEncoding == .url else { return }
        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
    
}
