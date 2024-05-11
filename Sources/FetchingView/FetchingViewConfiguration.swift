//
//  File.swift
//  
//
//  Created by Ratnesh Jain on 11/05/24.
//

import SwiftUI

/// A Fetching View configuration for custom fetching title and actions view in case of `error(message)`.
struct FetchingViewConfiguration {
    var title: String?
    var actionsView: AnyView?
}

extension FetchingViewConfiguration: EnvironmentKey {
    static var defaultValue: Self = {
        .init()
    }()
}

extension EnvironmentValues {
    
    /// A FetchingView Configuration property for SwiftUI environment.
    var fetchingViewConfiguration: FetchingViewConfiguration {
        get { self[FetchingViewConfiguration.self] }
        set { self[FetchingViewConfiguration.self] = newValue }
    }
}

extension View {
    
    /// A Error Actions view in case of `error(message)` state of `FetchingState`.
    ///
    /// - Parameter : A actions view to provide actions buttons like retry.
    /// - Returns: Same view.
    public func fetchingErrorActions<A: View>(@ViewBuilder _ actionsView: () -> A) -> some View {
        self.environment(\.fetchingViewConfiguration.actionsView, AnyView(actionsView()))
    }
    
    /// Provides a custom title for `.fetching` state of `FetchingState`.
    /// - Parameter title: A title to display when LoadingView is shown.
    /// - Returns: Same view
    public func fetchingTitle(_ title: String) -> some View {
        self.environment(\.fetchingViewConfiguration.title, title)
    }
}
