//
//  WarningText.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 12/6/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct WarningText: View {
    
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle")
                .symbolRenderingMode(.multicolor)
                .accessibilityHidden(true)
            Text(text)
        }
        .font(.callout)
        .foregroundStyle(.secondary)
    }
}

#Preview {
    WarningText("This feature isn't available!")
}
