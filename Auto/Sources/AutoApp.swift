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

    private let container: AppContainer
    private let viewContext: NSManagedObjectContext
    @StateObject private var coordinator: AppCoordinator

    init() {
        let container = AppContainer()
        self.container = container
        self.viewContext = container.container.resolve(NSManagedObjectContext.self)!
        _coordinator = StateObject(wrappedValue: container.container.resolve(AppCoordinator.self)!)
    }

    var body: some Scene {
        WindowGroup {
            coordinator.start()
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
