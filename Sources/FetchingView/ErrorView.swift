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
    let message: String
    @Environment(\.fetchingViewConfiguration.actionsView) var actionsViews: AnyView?
    
    public init(message: String) {
        self.message = message
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.secondary)
            Text(message)
            
            if let actionsViews {
                actionsViews
            }
        }
    }
}
