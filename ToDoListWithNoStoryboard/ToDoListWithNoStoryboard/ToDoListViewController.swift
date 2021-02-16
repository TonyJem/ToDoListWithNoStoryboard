/*
 Used Resources:
 https://softauthor.com/ios-uitableview-programmatically-in-swift/
 https://ioscoachfrank.com/remove-main-storyboard.html
 */

import UIKit

class ToDoListViewController: UIViewController {
    
    let todoItemsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let todoItems = TodoItemModel.getTodoItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoItemsTableView.delegate = self
        todoItemsTableView.dataSource = self
        
        setNavigation()
        
        addSubviewsToMainView()
        setConstraintsToTableView()
    }
    
}

extension ToDoListViewController {
    
    func setNavigation() {
        navigationItem.title = "ToDo List:"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    func addSubviewsToMainView() {
        view.addSubview(todoItemsTableView)
    }
    
    func setConstraintsToTableView() {
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
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todoItems[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
