//
//  File.swift
//  
//
//  Created by Ratnesh Jain on 11/05/24.
//

import SwiftUI

/// A View representing the `.fetching` state of `FetchingState`.
///
/// This is the inbuild view to be used by `FetchingView`.
public struct LoadingView: View {
    @Environment(\.fetchingViewConfiguration.title) var title: String?
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            ProgressView()
            Text(title ?? "Loading...")
        }
    }
}

