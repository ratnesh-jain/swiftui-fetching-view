//
//  FetchingState.swift
//  
//
//  Created by Ratnesh Jain on 11/05/24.
//

import Foundation

/// FetchingState represents different states of a time consuming task.
///  
/// - **Idle**: if the task is not initialized or not doing doing
/// anything, it can be represented as idle state.
///  
/// - **Fetching**: When the task is doing its work, that can be represented as fetching.
///
/// - **Fetched**: when the task is completed with a success result, it can be represented as fetched(task's value)
///
/// - **Error**: it can result in some failure then it can be represented as error(message).
///
///
///         @MainActor
///         class UsersViewModel: ObservableObject {
///             var userFetchingState: FetchingState<[User]> = .idle
///
///             func fetchUsers() async {
///                 userFetchingState = .fetching
///                 do {
///                     let users = try await service.fetchUsers()
///                     self.userFetchingState = .fetched(users)
///                 } catch {
///                     self.userFetchingState = .error(error.localizedDescription)
///                 }
///             }
///         }
///
///
public enum FetchingState<T>: Equatable, Sendable where T: Equatable & Sendable {
    case idle
    case fetching
    case fetched(T)
    case error(message: String)
}

extension FetchingState {
    
    /// A flag to represent if the state is in progress.
    public var isFetching: Bool {
        guard case .fetching = self else {
            return false
        }
        return true
    }
    
    /// A associated value of the successful task.
    public var value: T? {
        guard case .fetched(let t) = self else {
            return nil
        }
        return t
    }
    
    /// A error message for the failure result of the task.
    public var error: String? {
        guard case .error(let message) = self else {
            return nil
        }
        return message
    }
}
