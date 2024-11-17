//
//  ToDoItem.swift
//  ToDoListApp
//
//  Created by Данил Аникин on 17.11.2024.
//

import Foundation

class ToDoItem {
  let id: Int
  var todo: String
  var descripton: String
  var completed: Bool
  
  init(id: Int, todo: String, descripton: String = "", completed: Bool = false) {
    self.id = id
    self.todo = todo
    self.descripton = descripton
    self.completed = completed
  }
}
