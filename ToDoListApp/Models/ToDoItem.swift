//
//  ToDoItem.swift
//  ToDoListApp
//
//  Created by Данил Аникин on 17.11.2024.
//

import Foundation

struct ToDoItem: Decodable, Equatable {
  let id: Int
  var todo: String
  var description: String
  var completed: Bool
  var date: String
  
  init(id: Int, todo: String, description: String = "", completed: Bool = false, date: String? = nil) {
    self.id = id
    self.todo = todo
    self.description = description
    self.completed = completed
    
    if let date = date {
      self.date = date
    } else {
      let currentDate = Date()

      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yy"
      formatter.locale = Locale(identifier: "en_US_POSIX")

      let formattedDate = formatter.string(from: currentDate)
      self.date = formattedDate
    }
   
  }
}
