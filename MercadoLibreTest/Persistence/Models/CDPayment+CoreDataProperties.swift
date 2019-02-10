//
//  CDPayment+CoreDataProperties.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation
import CoreData

extension CDPayment {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPayment> {
        return NSFetchRequest<CDPayment>(entityName: "CDPayment")
    }
    
    @NSManaged public var bank: String?
    @NSManaged public var amount: Double
    @NSManaged public var installments: Double
    @NSManaged public var paymentMethod: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var title: String?
    
}
