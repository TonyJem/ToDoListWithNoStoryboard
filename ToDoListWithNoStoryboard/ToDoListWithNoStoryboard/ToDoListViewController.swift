/*
 Used Resources:
 https://softauthor.com/ios-uitableview-programmatically-in-swift/
 https://ioscoachfrank.com/remove-main-storyboard.html
 https://stackoverflow.com/questions/62617968/add-button-to-uitableview-cell-programmatically
 */

import UIKit

class ToDoListViewController: UIViewController {
    
    private let todoItemsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ItemCell.self, forCellReuseIdentifier: "Сell")
        return tableView
    }()
    
    private let model = TodoItemModel()
    
    private var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        todoItemsTableView.delegate = self
        todoItemsTableView.dataSource = self
    }
}

// MARK: - SetupUI
extension ToDoListViewController {
    
    private func setupUI() {
        setupTableUI()
        setNavigationBar()
        addSubviewsToMainView()
        setConstraintsToTableView()
    }
    
    private func setupTableUI() {
        view.backgroundColor = AppColors.backgroundColor
        todoItemsTableView.separatorColor = AppColors.tableCellSeparatorColor
    }
    
    private func setNavigationBar() {
        navigationItem.title = "ToDo List:"
        self.navigationController?.navigationBar.barTintColor = AppColors.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColors.navBarFontColor]
    }
    
    private func addSubviewsToMainView() {
        view.addSubview(todoItemsTableView)
    }
    
    private func setConstraintsToTableView() {
        NSLayoutConstraint.activate([
            todoItemsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todoItemsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            todoItemsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            todoItemsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Сell", for: indexPath) as! ItemCell
        cell.delegate = self
        cell.todoItem = model.todoItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        changeState(for: indexPath.row)
        tableView.reloadData()
    }
    
    private func changeState(for row: Int) {
        model.todoItems[row].isMarkedDone = model.changeState(at: row)
    }
}

//MARK: - ItemCellDelegate
extension ToDoListViewController: ItemCellDelegate {
    
    func deleteCell(cell: ItemCell) {
        guard let indexPath = todoItemsTableView.indexPath(for: cell) else { return }
        model.removeItem(at: indexPath.row)
        todoItemsTableView.reloadData()
    }
    
    func editCell(cell: ItemCell) {
        guard let indexPath = todoItemsTableView.indexPath(for: cell) else { return }
        self.editCellContent(at: indexPath)
    }
    
    private func editCellContent(at indexPath: IndexPath) {
        
        let cell = tableView(todoItemsTableView, cellForRowAt: indexPath) as! ItemCell
        
        alert = UIAlertController(title: "Edit your ToDoItem!", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
            textField.text = cell.todoItem?.title
        })
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let editAlertAction = UIAlertAction(title: "Submit", style: .default) { (createAlert) in
            guard let textFields = self.alert.textFields,
                  textFields.count > 0,
                  let textValue = self.alert.textFields?[0].text else { return }
            self.model.updateItem(at: indexPath.row, with: textValue)
            self.todoItemsTableView.reloadData()
        }
        
        alert.addAction(cancelAlertAction)
        alert.addAction(editAlertAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        guard let senderText = sender.text,
              alert.actions.indices.contains(1) else { return }
        let action = alert.actions[1]
        action.isEnabled = senderText.count > 0
    }
}
