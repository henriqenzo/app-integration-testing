//
//  IntegrationTestingApp.swift
//  IntegrationTesting
//
//  Created by Enzo Henrique Botelho Romão on 05/03/26.
//

import SwiftUI
import SwiftData

@main
struct IntegrationTestingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TodoTask.self)
    }
}
