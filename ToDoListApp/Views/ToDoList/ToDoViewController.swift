//
//  ToDoViewController.swift
//  ToDoListApp
//
//  Created by Данил Аникин on 17.11.2024.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let viewModel = ToDoListViewModel()
  
  let footerView = UIView()
  let tableView = UITableView()
  let footerLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    
    viewModel.updateUI = { [weak self] in
      self?.tableView.reloadData()
      self?.updateFooter()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    viewModel.loadTodos()
  }
  
  private func setupView() {
    // MARK: Title
    self.title = "Задачи"
    navigationController?.navigationBar.prefersLargeTitles = true
    
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
      footerLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor, constant: -17)
    ])
  }
  
  
  // MARK: - Footer
  private func setupFooter() {
    footerView.backgroundColor = .systemGroupedBackground
    footerView.translatesAutoresizingMaskIntoConstraints = false
    
    footerView.backgroundColor = .systemGroupedBackground
    
    footerLabel.frame = footerView.bounds
    footerLabel.textAlignment = .center
    footerLabel.font = UIFont.systemFont(ofSize: 14)
    footerLabel.textColor = .darkGray
    
    footerLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(footerView)
    footerView.addSubview(footerLabel)
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
  
  // MARK: - TableView
  
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.todos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
    let todo = viewModel.todos[indexPath.row]
    cell.textLabel?.text = todo.todo
    cell.detailTextLabel?.text = todo.descripton
    return cell
  }
}

