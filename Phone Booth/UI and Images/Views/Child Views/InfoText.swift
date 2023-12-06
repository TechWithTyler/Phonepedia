//
//  InfoText.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 12/6/23.
//  Copyright © 2023 SheftApps. All rights reserved.
//

import SwiftUI

struct InfoText: View {
    
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Image(systemName: "info.circle")
            Text(text)
        }
        .font(.callout)
        .foregroundStyle(.secondary)
    }
}

#Preview {
    InfoText("Info about a phone feature or term")
}
