//
//  DocumentLaunchBackgroundView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/31/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

#if os(iOS) || os(visionOS)
import SwiftUI

struct DocumentLaunchBackgroundView: View {

    @Environment(\.colorScheme) var systemTheme

    var gradient: Gradient {
        let color = Color.accentColor
        let secondaryColor: Color = systemTheme == .dark ? .gray : .white
        return Gradient(colors: [secondaryColor.mix(with: color, by: 0.5), color])
    }

    var body: some View {
        LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
    }
}

#Preview {
    DocumentLaunchBackgroundView()
}
#endif
