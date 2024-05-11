# Fetching View

A SwiftUI view for displaying various ongoing task states represented by FetchingState.

### Example Usage:

```swift
import FetchingView

@MainActor
class UsersViewModel: ObservableObject {
    @Published var userFetchingState: FetchingState<[User]> = .idle

    func fetchUsers() async {
        userFetchingState = .fetching
        do {
            let users = try await service.fetchUsers()
            self.userFetchingState = .fetched(users)
        } catch {
            self.userFetchingState = .error(error.localizedDescription)
        }
    }
}

struct UsersView: View {
    @StateObject var viewModel = UsersViewModel()
    
    var body: some View {
        FetchingView(fetchingState: viewModel.userFetchingState) { users in
            List(users) { ... }
        } 
        .fetchingTitle("Fetching users...")
        .fetchingErrorActions {
            Button("Retry again") {
                print("Retry button tapped")
            }
            .buttonStyle(.bordered)
        }
        .task {
            await viewModel.fetchUsers()
        }
    }
}
```
