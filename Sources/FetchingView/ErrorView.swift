//
//  File.swift
//  
//
//  Created by Ratnesh Jain on 11/05/24.
//

import SwiftUI

/// A View representing `.error(message)` state of `FetchingState`.
///
/// This is the inbuild view to be used by `FetchingView`.
public struct ErrorView: View {
    @Environment(\.errorMessage) var message
    @Environment(\.fetchingViewConfiguration.actionsView) var actionsViews: AnyView?
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.secondary)
            if let message {
                Text(message)
            }
            
            if let actionsViews {
                actionsViews
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
