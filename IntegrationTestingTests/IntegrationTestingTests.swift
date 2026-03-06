//
//  IntegrationTestingTests.swift
//  IntegrationTestingTests
//
//  Created by Enzo Henrique Botelho Romão on 05/03/26.
//

import XCTest
@testable import IntegrationTesting
import SwiftData

final class IntegrationTestingTests: XCTestCase {
    
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!
    var taskService: TodoTaskService!
    var taskViewModel: TodoTaskViewModel!

    override func setUpWithError() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: TodoTask.self, configurations: config)
        modelContext = ModelContext(modelContainer)
        modelContext.autosaveEnabled = false
        
        taskService = TodoTaskService(context: modelContext)
        taskViewModel = TodoTaskViewModel(service: taskService)
    }

    override func tearDown() {
        taskViewModel = nil
        taskService = nil
        modelContext = nil
        modelContainer = nil
    }
    
    func test_loadTask() throws {
        taskViewModel.loadTasks()
        
        XCTAssertEqual(taskViewModel.tasks.count, 0)
        
        let taskTitle = "New task"
        
        taskViewModel.addTask(title: taskTitle)
        taskViewModel.loadTasks()
        
        XCTAssertEqual(taskViewModel.tasks.count, 1)
    }
    
    func test_addTask() throws {
        let taskTitle = "New task"
        
        taskViewModel.addTask(title: taskTitle)
        
        XCTAssertEqual(taskViewModel.tasks.count, 1)
    }
    
    func test_concludeTask() throws {
        let taskTitle = "New task"
        
        taskViewModel.addTask(title: taskTitle)
        
        taskViewModel.toggleTask(taskViewModel.tasks.last!)
        
        XCTAssertEqual(taskViewModel.tasks.last?.isCompleted, true)
    }
    
    func test_unconcludeTask() throws {
        let taskTitle = "New task"
        
        taskViewModel.addTask(title: taskTitle)
        
        taskViewModel.toggleTask(taskViewModel.tasks.last!)
        taskViewModel.toggleTask(taskViewModel.tasks.last!)
        
        XCTAssertEqual(taskViewModel.tasks.last?.isCompleted, false)
    }
    
    func test_deleteTask() throws {
        let taskTitle = "New task"
        
        taskViewModel.addTask(title: taskTitle)
        
        XCTAssertEqual(taskViewModel.tasks.count, 1)
        
        taskViewModel.deleteTask(taskViewModel.tasks.last!)
        
        XCTAssertEqual(taskViewModel.tasks.count, 0)
    }

}
