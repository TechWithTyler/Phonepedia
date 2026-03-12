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

    // Whether the left/right arrows should be displayed.
    let showLeftRight: Bool

    // Whether the center button should be displayed.
    let showCenterButton: Bool

    // Whether the navigation button is a joystick, which is represented by showing the center button as a circle in a circle.
    let isJoystick: Bool

    // MARK: - Properties - Floats

    var upDownSpacing: CGFloat {
        return showCenterButton || showLeftRight ? 15 : 20
    }

    var leftCenterRightSpacing: CGFloat {
        return showCenterButton || isJoystick ? 15 : 50
    }

    // MARK: - Properties - Colors

    let shapeColor: Color = .secondary.opacity(0.15)

    // MARK: - Body

    var body: some View {
        VStack(alignment: .center) {
            Text("Navigation Button Example")
            ZStack {
                shape
                VStack(spacing: upDownSpacing) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .accessibilityLabel("Up")
                    HStack(alignment: .center, spacing: leftCenterRightSpacing) {
                        if showLeftRight {
                            Image(systemName: "arrowtriangle.left.fill")
                                .accessibilityLabel("Left")
                        }
                        if showCenterButton || isJoystick {
                            Image(systemName: isJoystick ? "circle.circle.fill" : "circle.fill")
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
        .dynamicTypeSize(.medium)
        .animation(.linear, value: showLeftRight)
        .animation(.linear, value: showCenterButton)
    }

    // MARK: - Navigation Button Shape

    @ViewBuilder
    var shape: some View {
        if showLeftRight {
            Circle()
                .fill(shapeColor)
                .frame(width: 100, height: 100)
        } else {
            Capsule()
                .fill(shapeColor)
                .frame(width: 50, height: 100)
        }
    }

}

// MARK: - Preview

#Preview("Up/Down") {
    NavigationButtonExampleView(showLeftRight: false, showCenterButton: false, isJoystick: false)
}

#Preview("Up/Down/Left/Right Button") {
    NavigationButtonExampleView(showLeftRight: true, showCenterButton: false, isJoystick: false)
}

#Preview("Up/Down/Left/Right Joystick") {
    NavigationButtonExampleView(showLeftRight: true, showCenterButton: false, isJoystick: true)
}

#Preview("Up/Down/Center") {
    NavigationButtonExampleView(showLeftRight: false, showCenterButton: true, isJoystick: false)
}

#Preview("Up/Down/Left/Right/Center Button") {
    NavigationButtonExampleView(showLeftRight: true, showCenterButton: true, isJoystick: false)
}

#Preview("Up/Down/Left/Right/Center Joystick") {
    NavigationButtonExampleView(showLeftRight: true, showCenterButton: true, isJoystick: true)
}
