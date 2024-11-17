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
  
  var updateUI: () -> Void = {}
}
