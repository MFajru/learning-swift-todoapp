//
//  ContentView.swift
//  todoapp
//
//  Created by Muhammad Fajru on 16/05/25.
//

import SwiftUI

struct ContentView: View {
    enum Field: Hashable {
        case todoEnum(id: UUID)
    }
    
    @State private var contentVM = ContentViewViewModel()
    
    @FocusState private var focusField: Field?
    
    var body: some View {
        ZStack(
            alignment: .top
        ) {
            ScrollView {
                LazyVStack(
                    alignment: .leading,
                    spacing: 10
                    
                )
                {
                    ForEach(contentVM.fetchedToDo) { fTodo in
                        Text(fTodo.title)
                    }
                    
                    ForEach($contentVM.toDoList) { $todo in
                        HStack {
                            Toggle(
                                isOn: $todo.isCompleted
                            ){}
                                .toggleStyle(ChecklistToggleStyle())
                            if !todo.isClicked {
                                Text(todo.text)
                                    .strikethrough(todo.isCompleted)
                                    .onTapGesture {
                                        contentVM.handleIsClicked(todo:&todo)
                                    }
                                
                            } else {
                                TextField(
                                    todo.text,
                                    text: $todo.text
                                )
                                .onSubmit {
                                    contentVM.handleIsClicked(todo:&todo)
                                }
                                .onAppear{focusField = .todoEnum(id: todo.id)}
                                .focused($focusField, equals: .todoEnum(id: todo.id))
                                .autocorrectionDisabled(true)
                                .strikethrough(todo.isCompleted)
                                .padding(.vertical, -1)
                                
                            }
                        }
                    }
                }
                .padding()
                .padding(.top, 30)
                .navigationTitle("Todo App")
                
                // toolbar for showing like footer menu
                //                                .toolbar {
                //                                    ToolbarItemGroup(placement: .bottomBar) {
                //                                        Spacer()
                //                                        Image(systemName: "plus")
                //                                    }
                //                                }
                //                                .frame(
                //                                    maxWidth: .infinity,
                //                                    maxHeight: .infinity,
                //                                    alignment: .topLeading
                //                                )
            }
            .task {
                 await contentVM.loadToDos()
            }
            .overlay(
                alignment: .topLeading
            ) {
                TextField(
                    "Enter Todo",
                    text: $contentVM.text,
                    axis: .vertical
                )
                .onSubmit {
                    contentVM.submitText()
                }
                .autocorrectionDisabled(true)
                .padding(.leading, 20)
                .padding(.vertical, 10)
                .background(Color.white)
            }
            .overlay(
                alignment: .bottomTrailing
            ) {
                Button {
                    print("Add")
                }
                label: {
                    Image(systemName: "plus")
                        .fontWeight(.bold)
                        .padding(20)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 2)
                    
                }
                .padding(.trailing, 20)
            }
        }
    }
}

struct ChecklistToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: configuration.isOn
                      ? "checkmark.circle.fill"
                      : "circle")
                .foregroundColor(
                    configuration.isOn
                    ? .green
                    : .primary
                )
                configuration.label
            }
        }
        .tint(.primary)
        .buttonStyle(.borderless)
    }
}


#Preview {
    NavigationStack {
        ContentView()
    }
}
