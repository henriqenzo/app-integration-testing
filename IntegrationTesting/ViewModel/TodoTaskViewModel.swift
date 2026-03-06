//
//  TodoTaskViewModel.swift
//  IntegrationTesting
//
//  Created by Enzo Henrique Botelho Romão on 05/03/26.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class TodoTaskViewModel {

    private let service: TodoTaskService

    var tasks: [TodoTask] = []

    init(service: TodoTaskService) {
        self.service = service
    }

    func loadTasks() {
        do {
            tasks = try service.fetchTasks()
        } catch {
            print("Erro ao buscar tasks")
        }
    }

    func addTask(title: String) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        do {
            try service.createTask(title: title)
            loadTasks()
        } catch {
            print("Erro ao criar task")
        }
    }

    func toggleTask(_ task: TodoTask) {
        do {
            try service.toggleTask(task)
            loadTasks()
        } catch {
            print("Erro ao atualizar task")
        }
    }

    func deleteTask(_ task: TodoTask) {
        do {
            try service.deleteTask(task)
            loadTasks()
        } catch {
            print("Erro ao deletar task")
        }
    }
}
