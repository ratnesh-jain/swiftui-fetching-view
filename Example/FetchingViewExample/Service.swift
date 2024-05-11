//
//  Service.swift
//  FetchingViewExample
//
//  Created by Ratnesh Jain on 11/05/24.
//

import Foundation

class Service {
    enum ServiceError: LocalizedError {
        case message(String)
        
        var errorDescription: String? {
            switch self {
            case .message(let string):
                return string
            }
        }
    }
    
    var shouldFail: Bool = false
    
    func fetchUsers() async throws -> [User] {
        try await Task.sleep(for: .seconds(2))
        if shouldFail {
            throw ServiceError.message("Something went wrong, Please try again!")
        }
        return [User(name: "Alex"), User(name: "John"), User(name: "Tim")]
    }
}
