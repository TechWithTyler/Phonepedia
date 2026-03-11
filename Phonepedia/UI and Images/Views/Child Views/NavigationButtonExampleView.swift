//
//  NavigationButtonExampleView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 3/11/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct NavigationButtonExampleView: View {

    // MARK: - Properties - Booleans

    let showLeftRight: Bool

    let showCenterButton: Bool

    // MARK: - Body

    var body: some View {
        VStack(alignment: .center) {
            Text("Navigation Button Example")
            ZStack {
                shape
                VStack(spacing: showCenterButton || showLeftRight ? 15 : 20) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .accessibilityLabel("Up")
                    HStack(alignment: .center, spacing: showCenterButton ? 15 : 50) {
                        if showLeftRight {
                            Image(systemName: "arrowtriangle.left.fill")
                                .accessibilityLabel("Left")
                        }
                        if showCenterButton {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 18))
                                .accessibilityLabel("Center Button")
                        }
                        if showLeftRight {
                            Image(systemName: "arrowtriangle.right.fill")
                                .accessibilityLabel("Right")
                        }
                    }
                    Image(systemName: "arrowtriangle.down.fill")
                        .accessibilityLabel("Down")
                }
                .font(.system(size: 18))
                .foregroundStyle(Color.primary)
            }
        }
    }

    // MARK: - Navigation Button Shape

    @ViewBuilder
    var shape: some View {
        if showLeftRight {
            Circle()
                .fill(Color.secondary.opacity(0.15))
                .frame(width: 100, height: 100)
        } else {
            Capsule()
                .fill(Color.secondary.opacity(0.15))
                .frame(width: 50, height: 100)
        }
    }
}

// MARK: - Preview

#Preview("Up/Down") {
    NavigationButtonExampleView(showLeftRight: false, showCenterButton: false)
}

#Preview("Up/Down/Left/Right") {
    NavigationButtonExampleView(showLeftRight: true, showCenterButton: false)
}

#Preview("Up/Down/Center") {
    NavigationButtonExampleView(showLeftRight: false, showCenterButton: true)
}

#Preview("Up/Down/Left/Right/Center") {
    NavigationButtonExampleView(showLeftRight: true, showCenterButton: true)
}
