//
//  ToDoDetailsViewController.swift
//  ToDoListApp
//
//  Created by Данил Аникин on 18.11.2024.
//

import UIKit

class ToDoDetailsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
  let inputTittleField = UITextField()
  let dateLabel = UILabel()
  let descriptionView = UITextView()
  
  weak var delegate: ToDoDetailsViewControllerDelegate?
  var toDoItem: ToDoItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if inputTittleField.text != "" {
      descriptionView.text = ""
      saveToDo()
    }
  }
  
  func setupView() {
    
    inputTittleField.font = UIFont.systemFont(ofSize: 34, weight: .bold)
    inputTittleField.delegate = self
    inputTittleField.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(inputTittleField)
    
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.textColor = .systemGray
    dateLabel.font = UIFont.systemFont(ofSize: 16)
    view.addSubview(dateLabel)
    
    descriptionView.font = UIFont.systemFont(ofSize: 16)
    descriptionView.delegate = self
    descriptionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(descriptionView)
    
    setFields()
    
    // MARK: Constraints
    NSLayoutConstraint.activate([
      inputTittleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      inputTittleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      inputTittleField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      
      dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      dateLabel.topAnchor.constraint(equalTo: inputTittleField.bottomAnchor, constant: 5),
      
      descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      descriptionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
      descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
    ])
  }
  
  func setFields() {
    if let toDoItem = toDoItem {
      inputTittleField.placeholder = toDoItem.todo
      descriptionView.text = toDoItem.description
      descriptionView.textColor = .systemGray
      dateLabel.text = toDoItem.date
    } else {
      inputTittleField.placeholder = "Введите задачу"
      descriptionView.text = "Добавьте описание к задаче"
      descriptionView.textColor = .systemGray
      let currentDate = Date()
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yy"
      formatter.locale = Locale(identifier: "en_US_POSIX")
      let formattedDate = formatter.string(from: currentDate)
      
      dateLabel.text = formattedDate
    }
  }
  
  // MARK: - TextView (Placeholder)
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == "Добавьте описание к задаче" {
      textView.text = ""
      textView.textColor = .black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text == "" {
      textView.text = "Добавьте описание к задаче"
      textView.textColor = .systemGray
    }
  }
  
  func saveToDo() {
    let todo = ToDoItem(id: 6, todo: inputTittleField.text ?? "", description: descriptionView.text ?? "")
    if toDoItem == nil {
      delegate?.didAddToDoItem(todo: todo)
    } else {
      delegate?.didChangeToDoItem(oldTodo: toDoItem!, newTodo: todo)
    }
    navigationController?.popViewController(animated: true)
  }
}

protocol ToDoDetailsViewControllerDelegate: AnyObject {
  func didAddToDoItem(todo: ToDoItem)
  func didChangeToDoItem(oldTodo: ToDoItem, newTodo: ToDoItem)
}
