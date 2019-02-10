//
//  CoreDataStack.swift
//  MercadoLibreTest
//
//  Created by Daniel Fernandez on 2/10/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared: CoreDataStack = CoreDataStack()
    
    var persistentContainer: NSPersistentContainer = {
        let pc = NSPersistentContainer(name: "MercadoLibreTest")
        pc.loadPersistentStores { (storeDescription, error) in
            
            if let error = error {
                fatalError("Loading store failed: \(error.localizedDescription)")
            }
        }
        
        return pc
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveMainContext() {
        guard viewContext.hasChanges else { return }
        
        do {
            try viewContext.save()
        } catch let err {
            fatalError("Error when saving mainContext \(err)")
        }
    }
    
}
