//
//  ContentViewViewModel.swift
//  todoapp
//
//  Created by Muhammad Fajru on 21/05/25.
//

import Foundation

@Observable
class ContentViewViewModel {
    var toDoList: [TodoModel] = []
    var text: String = ""
    
    func submitText() {
        let todo: TodoModel = TodoModel(
            text: text,
            isCompleted: false,
            isClicked: false
        )
        toDoList.append(todo)
        text = ""
    }
    
    func handleIsClicked(todo: inout TodoModel) {
        todo.isClicked.toggle()
    }
    
}
