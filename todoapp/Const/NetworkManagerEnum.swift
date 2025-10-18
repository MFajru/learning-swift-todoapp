//
//  NetworkManagerEnum.swift
//  todoapp
//
//  Created by Muhammad Fajru on 28/09/25.
//

enum NetworkManagerError: Error {
    case network(Error)
    case noData
    case decodingError
    case invalidURL
    case unknown
    case badResponse(statusCode: Int)
}
