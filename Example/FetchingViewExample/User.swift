//
//  User.swift
//  FetchingViewExample
//
//  Created by Ratnesh Jain on 11/05/24.
//

import Foundation

public struct User: Codable, Equatable {
    var id: UUID
    var name: String
    
    public init(id: UUID = .init(), name: String) {
        self.id = id
        self.name = name
    }
}
