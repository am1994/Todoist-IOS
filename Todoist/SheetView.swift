//
//  Sheet.swift
//  Todoist
//
//  Created by amina bekir on 17/11/2025.
//

import SwiftUI

struct SheetView: View {

    @State private var newTaskTitle = ""
    @Binding var tasks: [Task]
    @Binding var showingTaskEditor: Bool
    
    var body: some View {
            // Bottom sheet content
            VStack {
                Text("Add a new task")
                    .font(.headline)
                    .padding()
            
                
                HStack(){
                    Text("Task:")
                    
                    TextField("Type something...", text: $newTaskTitle)
                        .padding(8)
                        .frame(maxHeight: 40)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.secondary).opacity(0.5))
                    .padding(8)
                    
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 20)
                

                HStack(spacing: 16){
                    Button(action: {
                        showingTaskEditor = false
                    }) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle()) // Ensure the entire area is tappable
                    }
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.4))
                    .foregroundColor(.black)
                    .cornerRadius(30)
                    
                    
                    Button(action: {
                        if newTaskTitle.isEmpty {return}
                        let newTask = Task(id: UUID(), title: newTaskTitle )
                        tasks.append(newTask)
                        showingTaskEditor = false
                        newTaskTitle = ""
                    }) {
                        Text("Save")
                            .frame(maxWidth: .infinity) 
                            .contentShape(Rectangle()) // Ensure the entire area is tappable
                    }
                    .padding(.vertical, 8)
                    .disabled(newTaskTitle.isEmpty)
                    .background(newTaskTitle.isEmpty ? .gray.opacity(0.2) : .green)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                }
                .padding(.horizontal, 50)
            }
            .presentationDetents([.height(300)]) // Supported on iOS 16+
        }
}
 

#Preview {
    SheetView (
        tasks: .constant([]),
        showingTaskEditor: .constant(false)
    )
}
