//
//  PersistenceController.swift
//  SwiftUI-Search-Sample
//
//  Created by Takayuki Sakamoto on 2026/04/06.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FavoriteCat") // ここ重要 自分の .xcdatamodeld の名前に合わせる
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
