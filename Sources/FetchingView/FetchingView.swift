//
//  FetchingView.swift
//
//
//  Created by Ratnesh Jain on 11/05/24.
//

import SwiftUI

/// This view is the visual part of the `FetchingState`.
///
/// It utilises 3 different Views for each state of the `FetchingState`
///
///     FetchingView(fetchingState: .fetching) { (items: [String]) in
///         List {
///             ForEach(items, id: \.self) { item in
///                 Text(item)
///             }
///         }
///     }
///
/// ### Styling FetchingView
///
/// One can also provide a custom views like this.
///
///     FetchingView(fetchingState: .fetched(items)) { items in
///         List { ... }
///     } onFetching: {
///         VStack {
///             Image(systemName: "heart.fill")
///                 .font(.largeTitle)
///             Text("Fetching heart-rate information...")
///         }
///     } onError: { message in
///         VStack {
///             Image(systemName: "heart.slash")
///             Text(message)
///         }
///     }
///
/// To provide a custom fetching title,
///
///     FetchingView(fetchingState: .fetching) { (items: [String]) in
///         List {
///             ForEach(items, id: \.self) { item in
///                 Text(item)
///             }
///         }
///     }
///     .fetchingTitle("Fetching users....")
///
///
/// To provide an actions ui in case of failure
///
///     FetchingView(fetchingState: .fetching) { (items: [String]) in
///         List {
///             ForEach(items, id: \.self) { item in
///                 Text(item)
///             }
///         }
///     }
///     .fetchingErrorActions {
///         Button("Retry again") {
///             print("Retry button tapped")
///         }
///         .buttonStyle(.bordered)
///     }
///
public struct FetchingView<T, L, Content, E>: View where T: Equatable, L: View, Content: View, E: View {
    let fetchingState: FetchingState<T>
    let loadingView: () -> L
    var contentView: (T) -> Content
    var errorView: (String) -> E
    
    public init(
        fetchingState: FetchingState<T>,
        @ViewBuilder contentView: @escaping (T) -> Content,
        @ViewBuilder onFetching loadingView: @escaping () -> L,
        @ViewBuilder onError errorView: @escaping (String) -> E
    ) {
        self.fetchingState = fetchingState
        self.loadingView = loadingView
        self.contentView = contentView
        self.errorView = errorView
    }
    
    public var body: some View {
        switch fetchingState {
        case .idle:
            Color.clear
            
        case .fetching:
            loadingView()
            
        case .fetched(let value):
            contentView(value)
            
        case .error(let message):
            errorView(message)
        }
    }
}

extension FetchingView {
    
    /// A container that presents `FetchingState`'s different states.
    /// - Parameters:
    ///   - fetchingState: A fetching state which will drive the different view for each state.
    ///   - contentView: A view for displaying the success value.
    public init(
        fetchingState: FetchingState<T>,
        @ViewBuilder contentView: @escaping (T) -> Content
    ) where L == LoadingView, E == ErrorView {
        self.init(
            fetchingState: fetchingState,
            contentView: contentView,
            onFetching: { LoadingView() },
            onError: { ErrorView(message: $0) }
        )
    }
    
    /// A container that presents `FetchingState`'s different states.
    /// - Parameters:
    ///   - fetchingState: A fetching state which will drive the different view for each state.
    ///   - loadingView: A view for displaying the `fetchingState`
    ///   - contentView: A view for displaying the success value `fetched(data)`.
    public init(
        fetchingState: FetchingState<T>,
        @ViewBuilder contentView: @escaping (T) -> Content,
        @ViewBuilder onFetching loadingView: @escaping () -> L
    ) where E == ErrorView {
        self.init(
            fetchingState: fetchingState,
            contentView: contentView,
            onFetching: loadingView,
            onError: { ErrorView(message: $0) }
        )
    }
    
    /// A container that presents `FetchingState`'s different states.
    /// - Parameters:
    ///   - fetchingState: A fetching state which will drive the different view for each state.
    ///   - contentView: A view for displaying the success value `fetched(data)` state.
    ///   - errorView: A view for displaying the `error(message)` state.
    public init(
        fetchingState: FetchingState<T>,
        @ViewBuilder contentView: @escaping (T) -> Content,
        @ViewBuilder onError errorView: @escaping (String) -> E
    ) where L == LoadingView {
        self.init(
            fetchingState: fetchingState,
            contentView: contentView,
            onFetching: { LoadingView() },
            onError: errorView
        )
    }
}

// MARK: - Preview

#Preview("Mark 1") {
    FetchingView(fetchingState: .fetching) { (item: String) in
        Text("Item: \(item)")
    }
    .fetchingTitle("Fetching data...")
    .fetchingErrorActions {
        Button("Retry again") {
            print("Retry button tapped")
        }
        .buttonStyle(.bordered)
    }
}

#Preview("Mark 2") {
    FetchingView(fetchingState: .error(message: "Something went wrong")) { (item: String) in
        Text("Item: \(item)")
    } onFetching: {
        VStack {
            ProgressView()
            Text("Loading Items...")
        }
    }
}

#Preview("Mark 3") {
    FetchingView(fetchingState: .error(message: "Internet failed")) { (item: [String]) in
        List {
            ForEach(item, id: \.self) {
                Text($0)
            }
        }
    } onFetching: {
        VStack {
            Image(systemName: "heart")
                .symbolVariant(.fill)
                .font(.largeTitle)
            Text("Fetching heart information...")
        }
    } onError: { message in
        Text(message)
        Button("Retry") {
            
        }
        .buttonStyle(.bordered)
    }
}
