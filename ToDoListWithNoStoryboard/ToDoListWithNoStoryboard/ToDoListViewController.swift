/*
 Used Resources:
 https://softauthor.com/ios-uitableview-programmatically-in-swift/
 https://ioscoachfrank.com/remove-main-storyboard.html
 https://stackoverflow.com/questions/62617968/add-button-to-uitableview-cell-programmatically
 https://stackoverflow.com/questions/30022780/uibarbuttonitem-in-navigation-bar-programmatically
 https://stackoverflow.com/questions/33717698/create-navbar-programmatically-with-button-and-title-swift
 */

import UIKit

class ToDoListViewController: UIViewController {
    
    private let model = TodoItemModel()
    
    private var alert = UIAlertController()
    
//    Create TableView to use in our ViewController
    private let todoItemsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ItemCell.self, forCellReuseIdentifier: "Сell")
        return tableView
    }()
    
//    Property to keep current icon for "EditTask" button in Navigation Bar
    private var editTaskItemIcon = "pencil" {
        didSet {
            setNavigationBarButtons()
        }
    }

//    Property to keep current icon for "SortTasks" button in Navigation Bar
    private var sortTasksItemIcon = "arrow.up" {
        didSet {
            setNavigationBarButtons()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
//    Set current ViewController as delegate for TableViewDelegate and TableViewDataSource
        todoItemsTableView.delegate = self
        todoItemsTableView.dataSource = self
    }
  
//    Method, that be runing after tapping on "AddNewTask" button in NavigationBar (instead of IBAction)
    @objc func addNewTaskDidTapp() {
        alert = UIAlertController(title: "Create new task", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Put your task here"
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
        }
        
        let createAlertAction = UIAlertAction(title: "Create", style: .default) { (createAlert) in
            guard let itemTitle = self.alert.textFields?[0].text else { return }
            self.model.addItem(with: itemTitle)
            self.model.sortByTitle()
            self.todoItemsTableView.reloadData()
        }
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(cancelAlertAction)
        alert.addAction(createAlertAction)
        present(alert, animated: true, completion: nil)
        createAlertAction.isEnabled = false
    }
 
//    Method, that be runing after tapping on "EditTask" button in NavigationBar (instead of IBAction)
    @objc func editTasksDidTapp() {
        let editOn = "pencil.slash"
        let editOff = "pencil"
        todoItemsTableView.setEditing(!todoItemsTableView.isEditing, animated: true)
        model.editButtonClicked = !model.editButtonClicked
        editTaskItemIcon = model.editButtonClicked ? editOn : editOff
    }
    
//    Method, that be runing after tapping on "SortTasks" button in NavigationBar (instead of IBAction)
    @objc func sortTasksDidTapp() {
        let arrowUp = "arrow.up"
        let arrowDown = "arrow.down"
        model.sortedAscending = !model.sortedAscending
        sortTasksItemIcon = model.sortedAscending ? arrowUp : arrowDown
        model.sortByTitle()
        todoItemsTableView.reloadData()
    }
    
//    Method, that be runing everytime while text value textField in Alert is Changed
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        guard let senderText = sender.text,
              alert.actions.indices.contains(1) else { return }
        let action = alert.actions[1]
        action.isEnabled = senderText.count > 0
    }
}

// MARK: - SetupUI
extension ToDoListViewController {
    
//    Common method to setup UI for app, that ivolves all other simple methods
    private func setupUI() {
        setupTableUI()
        addSubviewsToMainView()
        setNavigationBar()
        setConstraintsToTableView()
        model.sortByTitle()
        todoItemsTableView.reloadData()
    }
    
//    Setup TableView UI (table backgound and separators colors)
    private func setupTableUI() {
        view.backgroundColor = AppColors.backgroundColor
        todoItemsTableView.separatorColor = AppColors.tableCellSeparatorColor
    }
    
//    Add Table view to ViewController's view
    private func addSubviewsToMainView() {
        view.addSubview(todoItemsTableView)
    }

//    Create Navigation bar UI and describes functionality
    private func setNavigationBar() {
        navigationItem.title = "Tasks"
        
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.barTintColor = AppColors.backgroundColor
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColors.navBarFontColor]
        
        setNavigationBarButtons()
    }

//    Create Navigation bar's buttons programmatically
    private func setNavigationBarButtons() {
        let addTaskItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewTaskDidTapp))
        let editTaskItem = UIBarButtonItem(image: UIImage(systemName: editTaskItemIcon), style: .plain, target: self, action: #selector(editTasksDidTapp))
        let sortTasksItem = UIBarButtonItem(image: UIImage(systemName: sortTasksItemIcon), style: .plain, target: self, action: #selector(sortTasksDidTapp))
        
        navigationItem.rightBarButtonItems = [addTaskItem, editTaskItem, sortTasksItem]
    }
    
//    Setup layout for tableView (Constraints)
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
    
//    Total amount of rows filled with Data in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.todoItems.count
    }
 
//    Populates tableView with cells, that contains Data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Сell", for: indexPath) as! ItemCell
        cell.delegate = self
        cell.todoItem = model.todoItems[indexPath.row]
        return cell
    }
  
//    Set of the row height for tableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
//    Change Item state (to isDone or notDone) when tapped on row in TableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        changeState(for: indexPath.row)
        tableView.reloadData()
    }
    
    private func changeState(for row: Int) {
        model.todoItems[row].isMarkedDone = model.changeState(at: row)
    }
 
//    Enables to change position for selected row in TableView
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        model.moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }
    
//    Enables to edit cells in TableView
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    Enables to Delete cells in TableView, while editing mode is ON
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            model.todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
 
//    Enables to sweatch ON editing mode by swiping on cell from middle to leading side
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in self?.editCellContent(at: indexPath)
            completionHandler(true)
        }
        editAction.backgroundColor = AppColors.editActionBackgroundColor
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
}

//MARK: - ItemCellDelegate
extension ToDoListViewController: ItemCellDelegate {
    
    //   Implementataion of deleteCell method of ItemCellDelegate protocol, remove selected item from model
    func deleteCell(cell: ItemCell) {
        guard let indexPath = todoItemsTableView.indexPath(for: cell) else { return }
        model.removeItem(at: indexPath.row)
        todoItemsTableView.reloadData()
    }
    //   Implementataion of editCell method of ItemCellDelegate protocol, enables to edit selected item and save updated in model
    func editCell(cell: ItemCell) {
        guard let indexPath = todoItemsTableView.indexPath(for: cell) else { return }
        self.editCellContent(at: indexPath)
    }
    
    private func editCellContent(at indexPath: IndexPath) {
        
        alert = UIAlertController(title: "Edit your ToDoItem!", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
            textField.text = self.model.todoItems[indexPath.row].title
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
}
