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
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let model = TodoItemModel()
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
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

//MARK: - ItemTableViewCellDelegate
extension ToDoListViewController: ItemTableViewCellDelegate {
    
    func deleteCell(cell: ItemTableViewCell) {
        guard let indexPath = todoItemsTableView.indexPath(for: cell) else { return }
        model.removeItem(at: indexPath.row)
        todoItemsTableView.reloadData()
    }
    
    func editCell(cell: ItemTableViewCell) {
        
    }
}
