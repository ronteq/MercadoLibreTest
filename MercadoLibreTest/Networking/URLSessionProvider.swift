//
//  URLSessionProvider.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

final class URLSessionProvider: ProviderProtocol {
    
    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (Response<T>) -> Void) where T: Decodable {
        let request = URLRequest(service: service)
        session.dataTask(request: request) { [weak self]  data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        }.resume()
    }
    
    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (Response<T>) -> Void) {
        guard error == nil else { return completion(.failure(.unknown(error?.localizedDescription ?? "Error"))) }
        guard let response = response else { return completion(.failure(.unknown("server_error".localized()))) }
        
        switch response.statusCode {
        case 200...299:
            guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data) else { return completion(.failure(.noData)) }
            completion(.success(model))
        default: completion(.failure(.unknown("server_error".localized())))
        }
    }
    
}
