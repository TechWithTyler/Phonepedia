//
//  InfoText.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 12/6/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct InfoText: View {
    
    // MARK: - Properties - Strings
    
    var text: String
    
    // MARK: - Initialization
    
    init(_ text: String) {
        self.text = text
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Image(systemName: "info.circle")
                .accessibilityHidden(true)
            Text(text)
        }
        .font(.callout)
        .foregroundStyle(.secondary)
    }
}

#Preview {
    InfoText("Info about a phone feature or term")
}
