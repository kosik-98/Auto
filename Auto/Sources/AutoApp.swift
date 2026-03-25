//
//  AutoApp.swift
//  Auto
//
//  Created by Dima Kosik on 4.03.26.
//

import SwiftUI
import CoreData

@main
struct AutoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
