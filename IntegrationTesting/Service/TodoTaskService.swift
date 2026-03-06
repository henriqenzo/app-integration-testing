//
//  TodoTaskService.swift
//  IntegrationTesting
//
//  Created by Enzo Henrique Botelho Romão on 05/03/26.
//

import Foundation
import SwiftData

class TodoTaskService {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func createTask(title: String) throws {
        let task = TodoTask(title: title)
        context.insert(task)
        try context.save()
    }

    func fetchTasks() throws -> [TodoTask] {
        let descriptor = FetchDescriptor<TodoTask>(
            sortBy: [SortDescriptor(\.createdAt)]
        )

        return try context.fetch(descriptor)
    }

    func toggleTask(_ task: TodoTask) throws {
        task.isCompleted.toggle()
        try context.save()
    }

    func deleteTask(_ task: TodoTask) throws {
        context.delete(task)
        try context.save()
    }
}
