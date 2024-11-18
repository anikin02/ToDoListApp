//
//  ToDoStorage.swift
//  ToDoListApp
//
//  Created by Данил Аникин on 17.11.2024.
//

import Foundation

class ToDoStorage {
  private init() {}
  
  public static let shared = ToDoStorage()
  
  public private(set) var todos: [ToDoItem] = [
    ToDoItem(id: 1, todo: "Buy elephant", description: "I want a elephant!"),
    ToDoItem(id: 2, todo: "Buy cat", description: "I want a cat! I want a cat! I want a cat! I want a cat! I want a cat! I want a cat! I want a cat! I want a cat! I want a cat! I want a cat! I want a cat! I want a cat!"),
    ToDoItem(id: 3, todo: "Buy dog", description: "I want a dog!"),
    ToDoItem(id: 4, todo: "Buy bird", description: "I want a bird!")
  ]
  
  func addTodo(todo: ToDoItem) {
    todos.append(todo)
  }
  
  func removeTodo(todo: ToDoItem) {
    if let index = todos.firstIndex(where: {$0 === todo}) {
      todos.remove(at: index)
    }
  }
}
