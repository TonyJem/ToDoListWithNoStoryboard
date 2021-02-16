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
        TodoItem(title: "TodoItem6", isMarkedDone: true)
    ]
}
