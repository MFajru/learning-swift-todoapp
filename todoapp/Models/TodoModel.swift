//
//  TodoModel.swift
//  todoapp
//
//  Created by Muhammad Fajru on 18/05/25.
//

import Foundation

struct TodoModel: Identifiable {
    var id = UUID()
    var text: String
    var isCompleted: Bool
    var isClicked: Bool
}

struct ToDoJsonPlaceholder: Decodable, Identifiable {
    let id: Int
    let title: String
    let completed: Bool
}
