//
//  DocumentLaunchPhonesAccessoryView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/21/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

#if os(iOS) || os(visionOS)

// MARK: - Imports

import SwiftUI

struct DocumentLaunchPhonesAccessoryView: View {

    // MARK: - Properties - Horizontal Size Class

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    // MARK: - Properties - Size

    @State private var size: CGSize = CGSize()

    // MARK: - Body

    var body: some View {
        if horizontalSizeClass == .regular {
            ZStack {
                DocumentLaunchPhoneView(xOffset: size.width / 2 - 500, yOffset: size.height / 2 - 250)
                DocumentLaunchPhoneView(xOffset: size.width / 2 + 300, yOffset: size.height / 2 - 250)
            }
            .onGeometryChange(for: CGSize.self) { proxy in
                proxy.size
            } action: { proxySize in
                size = proxySize
            }
        }
    }
}

// MARK: - Preview

#Preview {
    DocumentLaunchPhonesAccessoryView()
}
#endif
