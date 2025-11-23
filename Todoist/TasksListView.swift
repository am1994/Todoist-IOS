//
//  TasksListView.swift
//  Todoist
//
//  Created by amina bekir on 17/11/2025.
//

import SwiftUI

struct TasksListView: View {
    @State private var tasks: [Task] = []
    @State private var completedTasks: [Task] = []
    @State private var showingTaskEditor = false
    @State private var isChecked = false
    @State private var isSelecting = false
    @State private var selectedTasks: [Task] = []
    @State private var trailingText = "Select"
    
    var body: some View {
        NavigationStack {
            VStack( alignment: .leading, spacing: 0){
                HStack{
                    Text("")
                        .font(.callout)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                    
                    Text("Tasks")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(.leading)
                        .padding(.vertical)
                        .foregroundColor(.white)
                    
                    if(tasks.isEmpty){
                        Text("")
                            .font(.callout)
                            .padding(.horizontal)
                            .foregroundColor(.black)
                    } else {
                        Text(trailingText)
                            .font(.callout)
                            .padding(.horizontal)
                            .foregroundColor(.black)
                            .onTapGesture {
                                isSelecting.toggle()
                                if(!selectedTasks.isEmpty){
                                    let selectedIds = selectedTasks.map { $0.id }
                                    tasks.removeAll { task in
                                        selectedIds.contains(task.id)
                                    }
                                    selectedTasks.removeAll()
                                }
                                
                                trailingText =  isSelecting ? "Delete" : "Select"
                            }
                    }
                }
                .background(Color(.green))   // light bar background
                .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
                
                ZStack {
                    if tasks.isEmpty {
                        VStack {
                            Text("No tasks yet")
                                .foregroundColor(.gray)
                                .padding(.top, 20)
                            Spacer()
                        }
                    } else {
                                                List($tasks) { task in
                                                    let value = task.wrappedValue     // convert Binding<Task> -> Task
                        
                                                    HStack {
                                                        if isSelecting {
                                                            Checkbox(
                                                                isOn: isTaskSelected(value)
                                                            )
                                                        }
                        
                                                        Text(value.title)
                                                            .strikethrough(
                                                                completedTasks.contains(where: { $0.id == value.id }),
                                                                color: .gray
                                                            )
                        
                                                        Spacer()
                        
                                                        if completedTasks.contains(where: { $0.id == value.id }) {
                                                            Image(systemName: "checkmark")
                                                                .foregroundColor(.green)
                                                        }
                                                    }
                                                    .contentShape(Rectangle())
                                                    .onTapGesture {
                                                        if !isSelecting {
                                                            if let index = completedTasks.firstIndex(where: { $0.id == value.id }) {
                                                                completedTasks.remove(at: index)
                                                            } else {
                                                                completedTasks.append(value)
                                                            }
                                                        }
                                                    }
                                                }
                                                
                    }
                    
                        // Floating button overlay
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    showingTaskEditor.toggle();
                                }) {
                                    Image(systemName: "plus")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(.green)
                                        .clipShape(Circle())
                                        .shadow(radius: 4)
                                }
                                .padding(.trailing, 20)
                                .padding(.bottom, 20)
                                .sheet(isPresented: $showingTaskEditor) {
                                    SheetView(tasks: $tasks,
                                              showingTaskEditor: $showingTaskEditor)
                                }
                            }
                        }
                    }
                }
            }
    }
    
    func isTaskSelected(_ task: Task) -> Binding<Bool> {
        Binding(
            get: {
                selectedTasks.contains(where: { $0.id == task.id })
            },
            set: { isChecked in
                if isChecked {
                    if !selectedTasks.contains(where: { $0.id == task.id }) {
                        selectedTasks.append(task)
                    }
                } else {
                    selectedTasks.removeAll { $0.id == task.id }
                }
            }
        )
        
    }
}


#Preview {
    TasksListView()
}


struct Checkbox: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            Image(systemName: isOn ? "checkmark.square.fill" : "square")
                .font(.title2)
                .foregroundStyle(isOn ? .green : .gray)
        }
        .buttonStyle(.plain)
        
    }
}
