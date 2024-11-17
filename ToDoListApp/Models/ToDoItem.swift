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
  var date: String
  
  init(id: Int, todo: String, descripton: String = "", completed: Bool = false, date: String? = nil) {
    self.id = id
    self.todo = todo
    self.descripton = descripton
    self.completed = completed
    
    if let date = date {
      self.date = date
    } else {
      let currentDate = Date()

      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yy" // Формат для получения 09/10/24
      formatter.locale = Locale(identifier: "en_US_POSIX") // Гарантирует стабильный формат

      let formattedDate = formatter.string(from: currentDate)
      self.date = formattedDate
    }
   
  }
}
