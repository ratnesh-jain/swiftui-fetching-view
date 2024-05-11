//
//  ContentView.swift
//  FetchingViewExample
//
//  Created by Ratnesh Jain on 11/05/24.
//

import SwiftUI
import FetchingView

struct ContentView: View {
    @StateObject var viewModel: UsersViewModel = .init()
    
    var body: some View {
        NavigationStack {
            FetchingView(fetchingState: viewModel.userFetchingState) { users in
                List {
                    ForEach(users, id: \.id) { user in
                        Text(user.name)
                    }
                }
            }
            .fetchingTitle("Fetching Users....")
            .fetchingErrorActions {
                Button("Retry again") {
                    Task {
                        await viewModel.recoverFromFailure()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .task {
                await viewModel.fetchUsers()
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Test for failure") {
                        viewModel.testForFailure()
                        Task {
                            await viewModel.fetchUsers()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
