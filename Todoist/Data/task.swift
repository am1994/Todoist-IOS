//
//  task.swift
//  Todoist
//
//  Created by amina bekir on 23/11/2025.
//
import Foundation

struct Task: Identifiable {
    let id: UUID
    let title: String
    
    static func == (lhs: Task, rhs: Task) -> Bool {
          return lhs.id == rhs.id
      }
}


