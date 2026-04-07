//
//  SwiftUI_Search_SampleApp.swift
//  SwiftUI-Search-Sample
//
//  Created by Takayuki Sakamoto on 2026/03/16.
//

import SwiftUI
import CoreData

@main
struct SwiftUI_Search_SampleApp: App {
    
    let persistencecontroller = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistencecontroller.container.viewContext)
        }
    }
}
