import Foundation

//    Define TodoItem properties
struct TodoItem {
    var title: String?
    var isMarkedDone = false
}

class TodoItemModel {
    
//    Array to store all ToDOitems
    var todoItems = [
        TodoItem(title: "TodoItem1", isMarkedDone: false),
        TodoItem(title: "TodoItem2", isMarkedDone: true),
        TodoItem(title: "TodoItem3", isMarkedDone: false),
        TodoItem(title: "TodoItem4", isMarkedDone: true),
        TodoItem(title: "TodoItem5", isMarkedDone: false),
        TodoItem(title: "TodoItem6TodoItem6TodoItem6TodoItem6", isMarkedDone: true)
    ]
    
    // Property, that says how to sort ToDoItems
    var sortedAscending: Bool = true
    
    // Property, that says if Edit button in NavigationBAr was clicked
    var editButtonClicked: Bool = false
    
    // Switch state of ToDoItem from current to opposite
    func changeState(at item: Int) -> Bool {
        todoItems[item].isMarkedDone = !todoItems[item].isMarkedDone
    return todoItems[item].isMarkedDone
    }
    
    // Delete ToDoItem from "todoItems" array
    func removeItem(at index: Int) {
        todoItems.remove(at: index)
    }
    
    // Change position of ToDoItem in "todoItems" array from current to new
    func moveItem(fromIndex: Int, toIndex: Int) {
        let from = todoItems[fromIndex]
        todoItems.remove(at: fromIndex)
        todoItems.insert(from, at: toIndex)
    }
    
    // Change title of ToDoItem in "todoItems" array to new
    func updateItem(at index: Int, with newTitle: String) {
        todoItems[index].title = newTitle
    }
    
    // Append new ToDoItem to "todoItems" array
    func addItem(with itemTitle: String, isMarkedDone: Bool = false) {
        todoItems.append(TodoItem(title: itemTitle, isMarkedDone: isMarkedDone))
    }
    
    // Sort all ToDoItems in "todoItems" array depending on current "sortedAscending" value
    func sortByTitle() {
        todoItems.sort {
            sortedAscending ? $0.title?.lowercased() ?? "" < $1.title?.lowercased() ?? "" : $0.title?.lowercased() ?? "" > $1.title?.lowercased() ?? ""
        }
    }

}
