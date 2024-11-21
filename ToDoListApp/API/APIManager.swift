//
//  APIManager.swift
//  ToDoListApp
//
//  Created by Данил Аникин on 20.11.2024.
//

import Foundation

class APIManager {
  static let shared = APIManager()
  
  func getTodos(completion: @escaping (APIItems) -> Void) {
    let urlString: String = "https://dummyjson.com/todos"
    guard let url = URL(string: urlString) else { return }
  
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
      if error != nil {
        print(0)
        print(error!.localizedDescription)
      } else if let data = data {
        do {
          let decoder = JSONDecoder()
          let response = try decoder.decode(APIItems.self, from: data)
          completion(response)
        } catch {
          print(error.localizedDescription)
        }
      }
    })
    task.resume()
  }
}

struct APIItem: Decodable, Equatable {
  let id: Int
  let todo: String
  let completed: Bool
  let userId: Int
}


struct APIItems: Decodable {
  var todos: [APIItem]
}
