//
//  ListEmptyView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 5/1/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct ListEmptyView: View {

    // MARK: - Body

    var body: some View {
        Text("No phones")
            .font(.largeTitle)
            .foregroundStyle(.secondary)
    }

}

// MARK: - Preview

#Preview {
    ListEmptyView()
}
