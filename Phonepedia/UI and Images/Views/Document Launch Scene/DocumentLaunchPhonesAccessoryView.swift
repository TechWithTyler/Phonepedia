//
//  DocumentLaunchPhonesAccessoryView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/21/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

#if os(iOS) || os(visionOS)

// MARK: - Imports

import SwiftUI

struct DocumentLaunchPhonesAccessoryView: View {

    // MARK: - Properties - Horizontal Size Class

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    // MARK: - Properties - Geometry Proxy

    @State var geometry: DocumentLaunchGeometryProxy? = nil

    var frame: CGRect {
        if let geometry = geometry {
            return geometry.titleViewFrame
        } else {
            return CGRect()
        }
    }

    // MARK: - Body

    var body: some View {
        if horizontalSizeClass == .regular {
            ZStack {
                DocumentLaunchPhoneView(xOffset: frame.width - 250, yOffset: frame.maxY - 200)
                DocumentLaunchPhoneView(xOffset: frame.width + 250, yOffset: frame.maxY - 200)
                DocumentLaunchPhoneView(xOffset: frame.width - 250, yOffset: frame.minY + 200)
                DocumentLaunchPhoneView(xOffset: frame.width + 250, yOffset: frame.minY + 200)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    DocumentLaunchPhonesAccessoryView()
}
#endif
