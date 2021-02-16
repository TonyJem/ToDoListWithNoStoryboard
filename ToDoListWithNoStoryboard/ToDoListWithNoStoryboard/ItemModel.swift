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
    
    func changeState(at item: Int) -> Bool {
        todoItems[item].isMarkedDone = !todoItems[item].isMarkedDone
    return todoItems[item].isMarkedDone
    }
    
    func removeItem(at index: Int) {
        todoItems.remove(at: index)
    }
}
