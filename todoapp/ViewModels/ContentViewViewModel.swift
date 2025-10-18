//
//  ContentViewViewModel.swift
//  todoapp
//
//  Created by Muhammad Fajru on 21/05/25.
//

import Foundation

@MainActor
@Observable
class ContentViewViewModel {
    var toDoList: [TodoModel] = [TodoModel(
        text: "I want to sleep at 9 pm", isCompleted: false, isClicked: false
    ), TodoModel(
        text: "I want to play padel", isCompleted: false, isClicked: false
    ), TodoModel(
        text: "I want to watch some great movies", isCompleted: false, isClicked: false
    )]
    var text: String = ""
    
    var errorMsg: String?
    var fetchedToDo: [ToDoJsonPlaceholder] = []
    
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
    
    // pure fetch, just fetch the data
    func fetchToDos() async throws -> [ToDoJsonPlaceholder]{
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos?_page=1&_limit=10") else {
            throw NetworkManagerError.invalidURL
        }
        
        return try await NetworkManager.shared.fetchData(from: url)
        
    }
    
    // load the data to be shown in the view (data transformation, etc, do in here)
    func loadToDos() async{
        do {
            let data = try await fetchToDos()
            print(data)
            fetchedToDo = data
        } catch {
            errorMsg = error.localizedDescription
        }
    }
    
}
