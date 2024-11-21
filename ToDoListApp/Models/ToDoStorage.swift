//
//  ToDoStorage.swift
//  ToDoListApp
//
//  Created by Данил Аникин on 17.11.2024.
//

import Foundation

class ToDoStorage {
  public static let shared = ToDoStorage()
  
  public private(set) var todos: [ToDoItem] = []
  
  private init() {}
  
  func loadTodos(todos: [ToDoItem]) {
    self.todos = todos
  }

  func addTodo(todo: ToDoItem) {
    todos.append(todo)
  }
  
  func removeTodo(todo: ToDoItem) {
    if let index = todos.firstIndex(where: {$0 == todo}) {
      todos.remove(at: index)
    }
  }
  
  func changeTodo(oldTodo: ToDoItem, newTodo: ToDoItem){
    if let index = todos.firstIndex(where: {$0 == oldTodo}) {
      todos[index] = newTodo
    }
  }
}
