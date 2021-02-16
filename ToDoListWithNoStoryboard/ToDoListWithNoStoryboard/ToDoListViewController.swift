/*
 Used Resources:
 https://softauthor.com/ios-uitableview-programmatically-in-swift/
 https://ioscoachfrank.com/remove-main-storyboard.html
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
        
        setupTableUI()

        todoItemsTableView.delegate = self
        todoItemsTableView.dataSource = self
        
        setNavigation()
        
        addSubviewsToMainView()
        setConstraintsToTableView()
    }
    
}

extension ToDoListViewController {
    
    private func setupTableUI() {
        view.backgroundColor = AppColors.backgroundColor
        todoItemsTableView.separatorColor = AppColors.tableCellSeparatorColor
    }
    
    private func setNavigation() {
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

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        cell.todoItem = model.todoItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
