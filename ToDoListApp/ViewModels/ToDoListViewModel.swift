//
//  ToDoListViewModel.swift
//  ToDoListApp
//
//  Created by Данил Аникин on 17.11.2024.
//

import Foundation

class ToDoListViewModel {
  
  var todos: [ToDoItem] = [] {
    didSet {
      updateUI()
    }
  }
  
  func loadTodos() {
    todos = ToDoStorage.shared.todos
  }
  
  func addTodo(todo: ToDoItem) {
    ToDoStorage.shared.addTodo(todo: todo)
    todos = ToDoStorage.shared.todos
  }
  
  func removeTodo(todo: ToDoItem) {
    ToDoStorage.shared.removeTodo(todo: todo)
    todos = ToDoStorage.shared.todos
  }
  
  func changeTodo(oldTodo: ToDoItem, newTodo: ToDoItem) {
    ToDoStorage.shared.changeTodo(oldTodo: oldTodo, newTodo: newTodo)
    todos = ToDoStorage.shared.todos
  }
  
  var updateUI: () -> Void = {}
}
