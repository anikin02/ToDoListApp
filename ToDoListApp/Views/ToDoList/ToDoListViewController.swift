//
//  ToDoListViewController.swift
//  ToDoListApp
//
//  Created by Данил Аникин on 17.11.2024.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ToDoDetailsViewControllerDelegate {
  
  let viewModel = ToDoListViewModel()
  
  let footerView = UIView()
  let tableView = UITableView()
  let footerLabel = UILabel()
  let addToDoButton = UIButton(type: .system)
  
  override func viewWillAppear(_ animated: Bool){
    super.viewWillAppear(animated)
    
    viewModel.loadTodos()
    updateFooter()
    
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.title = "Задачи"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    
    viewModel.updateUI = { [weak self] in
      self?.tableView.reloadData()
      self?.updateFooter()
    }
    
    let backButton = UIBarButtonItem()
    backButton.title = "Назад"
    backButton.tintColor = .systemYellow
    navigationItem.backBarButtonItem = backButton
  }
  
  private func setupView() {
    setupTableView()
    setupFooter()
    
    // MARK: Constraints
    NSLayoutConstraint.activate([
      // TableView
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
      
      // FooterView
      footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      footerView.heightAnchor.constraint(equalToConstant: 83),
      
      // FooterLabel
      footerLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
      footerLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor, constant: -17),
      
      // AddToDoButton
      addToDoButton.centerYAnchor.constraint(equalTo: footerLabel.centerYAnchor),
      addToDoButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20)
    ])
  }
  
  
  // MARK: - Footer
  
  private func setupFooter() {
    // FooterView
    footerView.backgroundColor = .systemGroupedBackground
    footerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(footerView)
    
    // FooterLabel
    footerLabel.frame = footerView.bounds
    footerLabel.textAlignment = .center
    footerLabel.font = UIFont.systemFont(ofSize: 14)
    footerLabel.textColor = .darkGray
    footerLabel.translatesAutoresizingMaskIntoConstraints = false
    footerView.addSubview(footerLabel)
    
    //AddToDoButton
    addToDoButton.frame = footerView.bounds
    addToDoButton.tintColor = .systemYellow
    let image = UIImage(systemName: "square.and.pencil")?
      .withConfiguration(UIImage.SymbolConfiguration(pointSize: 22, weight: .medium))
    addToDoButton.setImage(image, for: .normal)
    addToDoButton.addTarget(self, action: #selector(openAddToDo), for: .touchUpInside)
    addToDoButton.translatesAutoresizingMaskIntoConstraints = false
    footerView.addSubview(addToDoButton)
  }
  
  private func updateFooter() {
    let count = viewModel.todos.count
    var footerText: String
    
    switch count {
    case 0:
      footerText = "Нет задач"
    case 1:
      footerText = "1 Задача"
    default:
      footerText = "\(count) Задач"
    }
    
    footerLabel.text = footerText
  }
  
  @objc func openAddToDo() {
    let addToDoViewController = ToDoDetailsViewController()
    addToDoViewController.delegate = self
    navigationController?.pushViewController(addToDoViewController, animated: true)
  }
  
  func didAddToDoItem(todo: ToDoItem) {
    viewModel.addTodo(todo: todo)
  }
  
  func didChangeToDoItem(oldTodo: ToDoItem, newTodo: ToDoItem) {
    viewModel.changeTodo(oldTodo: oldTodo, newTodo: newTodo)
  }
  
  // MARK: - TableView
  
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.todos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ToDoTableViewCell else {
      return UITableViewCell()
    }
    cell.configure(with: viewModel.todos[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions -> UIMenu? in
      let todo = self.viewModel.todos[indexPath.row]
      let changeAction = UIAction(title: "Редактировать",
                                  image: UIImage(systemName: "square.and.pencil"),
                                  identifier: nil,
                                  discoverabilityTitle: nil) { action in
        let addToDoViewController = ToDoDetailsViewController()
        addToDoViewController.toDoItem = todo
        addToDoViewController.delegate = self
        self.navigationController?.pushViewController(addToDoViewController, animated: true)
      }
      let shareAction = UIAction(title: "Поделиться",
                                  image: UIImage(systemName: "square.and.arrow.up"),
                                  identifier: nil,
                                  discoverabilityTitle: nil) { action in
        UIPasteboard.general.string = todo.todo
      }
      let removeAction = UIAction(title: "Удалить",
                                  image: UIImage(systemName: "trash"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  attributes: .destructive) { action in
        self.viewModel.removeTodo(todo: todo)
      }
      return UIMenu(image: nil, identifier: nil, options: [], children: [changeAction, shareAction, removeAction])
    }
  }
}

