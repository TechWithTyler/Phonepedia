//
//  InfoText.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 12/6/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

/// Displays an info icon and the given text.
struct InfoText: View {
    
    // MARK: - Properties - Strings
    
    /// The text to display.
    var text: String
    
    /// The number of lines in the text.
    var lines: [String] {
        return text.components(separatedBy: .newlines)
    }
    
    // MARK: - Initialization
    
    /// Creates a new `InfoText` with the given text. If `text` contains multiple lines, the text is displayed as a `List` of `Text` views, one for each line.
    init(_ text: String) {
        self.text = text
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Image(systemName: "info.circle")
                .accessibilityHidden(true)
            if lines.count == 1 {
                Text(text)
            } else {
                VStack(alignment: .listRowSeparatorLeading) {
                    List(lines, id: \.self) { line in
                        Text(line)
                    }
                    .listRowSeparator(.hidden)
                }
            }
        }
        .font(.callout)
        .foregroundStyle(.secondary)
    }
}

#Preview("Single-line") {
    InfoText("Info about a phone feature or term")
}

#Preview("Multi-line") {
    InfoText("Selecting this option does this.\nSelecting that option does that.")
}
