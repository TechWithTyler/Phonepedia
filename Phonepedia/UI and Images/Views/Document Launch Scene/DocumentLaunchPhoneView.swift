//
//  DocumentLaunchPhoneView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/31/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

#if os(iOS) || os(visionOS)

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct DocumentLaunchPhoneView: View {

    // MARK: - Properties - Floats

    var xOffset: CGFloat

    var yOffset: CGFloat

    // MARK: - Properties - System Theme

    @Environment(\.colorScheme) var systemTheme

    // MARK: - Body

    var body: some View {
        Image(.phoneDetailed)
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .padding()
            .background {
                    (systemTheme == .dark ? Color.black : Color.white).opacity(0.1)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(radius: 5)
            }
            .offset(x: xOffset, y: yOffset)
    }
}

// MARK: - Preview

#Preview {
    DocumentLaunchPhoneView(xOffset: 0, yOffset: 0)
}
#endif
