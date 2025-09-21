//
//  NetworkManager.swift
//  todoapp
//
//  Created by Muhammad Fajru on 22/06/25.
//

import SwiftUI



class NetworkManager {
    static let shared = NetworkManager();
    
    // Make class singleton (not able to create new object)
    private init () {}
    
    enum NetworkManagerError: Error {
        case network(Error)
        case noData
        case decodingError
        case invalidURL
        case unknown
        case badResponse(statusCode: Int)
    }
    
    func fetchData<T:Decodable>(from url:URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkManagerError.badResponse(statusCode: -1)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkManagerError.badResponse(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkManagerError.decodingError
        }
    }
    
    func fetchToDos() async throws -> [ToDoJsonPlaceholder] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            throw NetworkManagerError.invalidURL
        }
        
        return try await fetchData(from: url)
        
    }
    
    
    
}
