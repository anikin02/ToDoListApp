//
//  ToDoTableViewCell.swift
//  ToDoListApp
//
//  Created by Данил Аникин on 17.11.2024.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
  private let titleLabel = UILabel()
  private let descriptionLabel = UILabel()
  private let dateLabel = UILabel()
  private let toggleButton = UIButton(type: .system)
  
  private var todo: ToDoItem?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Настройка UI
  func setupCell() {
    titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
    titleLabel.numberOfLines = 1
    contentView.addSubview(titleLabel)
    
    descriptionLabel.font = .systemFont(ofSize: 14)
    descriptionLabel.numberOfLines = 2
    contentView.addSubview(descriptionLabel)
    
    dateLabel.font = .systemFont(ofSize: 14)
    dateLabel.numberOfLines = 1
    dateLabel.textColor = .systemGray
    contentView.addSubview(dateLabel)
    
    toggleButton.addTarget(self, action: #selector(toggleCompleted), for: .touchUpInside)
    contentView.addSubview(toggleButton)
    
    toggleButton.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      toggleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      toggleButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 64),
      titleLabel.centerYAnchor.constraint(equalTo: toggleButton.centerYAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      
      descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
      
      dateLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
      dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
      dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
    ])
  }
  
  // MARK: - Configure
  func configure(with todo: ToDoItem) {
    self.todo = todo
    titleLabel.text = todo.todo
    descriptionLabel.text = todo.description
    dateLabel.text = todo.date
    updateAppearance()
  }
  
  private func updateAppearance() {
    let imageName = todo?.completed == true ? "checkmark.circle" : "circle"
    let image = UIImage(systemName: imageName)?
      .withConfiguration(UIImage.SymbolConfiguration(pointSize: 22, weight: .thin))
    toggleButton.setImage(image, for: .normal)
    toggleButton.tintColor = todo?.completed == true ? .systemYellow : .systemGray
    
    titleLabel.textColor = todo?.completed == true ? .systemGray : .label
    
    if let todo = todo {
      let attributes: [NSAttributedString.Key: Any]
      if todo.completed {
        attributes = [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
      } else {
        attributes = [:]
      }
      let attributedString = NSAttributedString(string: titleLabel.text ?? "", attributes: attributes)
      titleLabel.attributedText = attributedString
    }
    
    descriptionLabel.textColor = todo?.completed == true ? .systemGray : .label
  }
  
  // MARK: - Button???
  @objc private func toggleCompleted() {
    self.todo?.completed.toggle()
    updateAppearance()
  }
}
