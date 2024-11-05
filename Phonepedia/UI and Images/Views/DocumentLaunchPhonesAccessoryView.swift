//
//  DocumentLaunchPhonesAccessoryView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/21/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct DocumentLaunchPhonesAccessoryView: View {

    // MARK: - Properties - Horizontal Size Class

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    // MARK: - Properties - Size

    @State private var size: CGSize = CGSize()

    // MARK: - Body

    var body: some View {
        ZStack {
            Image(.phone)
                .resizable()
                .offset(x: size.width / 2 - 600, y: size.height / 2 - 250)
                .scaledToFit()
                .frame(width: 200)
                .opacity(horizontalSizeClass == .compact ? 0 : 1)
            Image(.phone)
                .resizable()
                .offset(x: size.width / 2 + 400, y: size.height / 2 - 250)
                .scaledToFit()
                .frame(width: 200)
                .opacity(horizontalSizeClass == .compact ? 0 : 1)
        }
        .onGeometryChange(for: CGSize.self) { proxy in
            proxy.size
        } action: { proxySize in
            size = proxySize
        }
    }
}

#Preview {
    DocumentLaunchPhonesAccessoryView()
}
