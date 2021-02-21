import Foundation

struct TodoItem {
    var title: String?
    var isMarkedDone = false
}

class TodoItemModel {
    
    var todoItems = [
        TodoItem(title: "TodoItem1", isMarkedDone: false),
        TodoItem(title: "TodoItem2", isMarkedDone: true),
        TodoItem(title: "TodoItem3", isMarkedDone: false),
        TodoItem(title: "TodoItem4", isMarkedDone: true),
        TodoItem(title: "TodoItem5", isMarkedDone: false),
        TodoItem(title: "TodoItem6TodoItem6TodoItem6TodoItem6", isMarkedDone: true)
    ]
    
    var sortedAscending: Bool = true
    var editButtonClicked: Bool = false
    
    func changeState(at item: Int) -> Bool {
        todoItems[item].isMarkedDone = !todoItems[item].isMarkedDone
    return todoItems[item].isMarkedDone
    }
    
    func removeItem(at index: Int) {
        todoItems.remove(at: index)
    }
    
    func moveItem(fromIndex: Int, toIndex: Int) {
        let from = todoItems[fromIndex]
        todoItems.remove(at: fromIndex)
        todoItems.insert(from, at: toIndex)
    }
    
    func updateItem(at index: Int, with newTitle: String) {
        todoItems[index].title = newTitle
    }
    
    func addItem(with itemTitle: String, isMarkedDone: Bool = false) {
        todoItems.append(TodoItem(title: itemTitle, isMarkedDone: isMarkedDone))
    }
    
    func sortByTitle() {
        todoItems.sort {
            sortedAscending ? $0.title?.lowercased() ?? "" < $1.title?.lowercased() ?? "" : $0.title?.lowercased() ?? "" > $1.title?.lowercased() ?? ""
        }
    }

}
