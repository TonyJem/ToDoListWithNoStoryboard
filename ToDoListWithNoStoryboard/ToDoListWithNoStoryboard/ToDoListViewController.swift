/*
Used Resources:
https://softauthor.com/ios-uitableview-programmatically-in-swift/
https://ioscoachfrank.com/remove-main-storyboard.html
*/

import UIKit

class ToDoListViewController: UIViewController {
    
    private let todoItems = TodoItemModel.getTodoItems()

    override func viewDidLoad() {
        super.viewDidLoad()

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
