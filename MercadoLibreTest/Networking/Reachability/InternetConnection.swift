//
//  InternetConnection.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/9/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation

struct InternetConnection {
    
    static func isOn() -> Bool {
        let reachability = Reachability.forInternetConnection()
        let networkStatus = reachability?.currentReachabilityStatus().rawValue
        return networkStatus != 0
    }
    
}
