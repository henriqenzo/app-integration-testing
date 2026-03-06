//
//  TodoTask.swift
//  IntegrationTesting
//
//  Created by Enzo Henrique Botelho Romão on 05/03/26.
//

import Foundation
import SwiftData

@Model
class TodoTask {

    var id: UUID
    var title: String
    var isCompleted: Bool
    var createdAt: Date

    init(title: String) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
        self.createdAt = Date()
    }
}
