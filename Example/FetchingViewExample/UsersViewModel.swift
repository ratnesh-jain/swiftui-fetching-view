//
//  UsersViewModel.swift
//  FetchingViewExample
//
//  Created by Ratnesh Jain on 11/05/24.
//

import Foundation
import FetchingView

class UsersViewModel: ObservableObject {
    @Published var userFetchingState: FetchingState<[User]> = .idle
    private let service = Service()
    
    func fetchUsers() async {
        userFetchingState = .fetching
        do {
            let users = try await service.fetchUsers()
            userFetchingState = .fetched(users)
        } catch {
            userFetchingState = .error(message: error.localizedDescription)
        }
    }
    
    func testForFailure() {
        service.shouldFail = true
    }
    
    func recoverFromFailure() async {
        service.shouldFail = false
        await fetchUsers()
    }
}
