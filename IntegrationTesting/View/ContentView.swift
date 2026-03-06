//
//  ContentView.swift
//  IntegrationTesting
//
//  Created by Enzo Henrique Botelho Romão on 05/03/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var context
    @State private var viewModel: TodoTaskViewModel?

    @State private var newTask = ""

    var body: some View {

        VStack {

            HStack {
                TextField("Nova tarefa", text: $newTask)
                    .textFieldStyle(.roundedBorder)

                Button("Adicionar") {
                    viewModel?.addTask(title: newTask)
                    newTask = ""
                }
            }

            List {
                ForEach(viewModel?.tasks ?? []) { task in
                    HStack {
                        Text(task.title)

                        Spacer()

                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                viewModel?.toggleTask(task)
                            }
                    }
                }
                .onDelete { indexSet in
                    guard let index = indexSet.first,
                          let task = viewModel?.tasks[index]
                    else { return }

                    viewModel?.deleteTask(task)
                }
            }

        }
        .padding()
        .onAppear {
            if viewModel == nil {
                let service = TodoTaskService(context: context)
                viewModel = TodoTaskViewModel(service: service)
            }

            viewModel?.loadTasks()
        }
    }
}

#Preview {
    ContentView()
}
