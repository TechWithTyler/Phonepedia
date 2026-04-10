//
//  ColorStack.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/22/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct ColorStack: View {

    // MARK: - Properties - Colors

    var mainColor: Color

    var secondaryColor: Color?

    var accentColor: Color?

    // MARK: - Properties - Booleans

    // Whether all colors match.
    var allColorsMatch: Bool {
        // 1. Create an array containing only the present colors.
        let colors = [mainColor, secondaryColor, accentColor].compactMap { $0 }
        // 2. Make sure we can get the first color. Otherwise, return true.
        guard let first = colors.first else { return true }
        // 3. Return whether all colors match by checking if each one matches the first color.
        return colors.allSatisfy { $0 == first }
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 2) {
            colorCircle(for: mainColor, label: "M")
            if let secondaryColor = secondaryColor {
                colorCircle(for: secondaryColor, label: "S")
            }
            if let accentColor = accentColor {
                colorCircle(for: accentColor, label: "A")
            }
        }
    }

    // MARK: - Color Circle

    @ViewBuilder
    func colorCircle(for color: Color, label: String) -> some View {
#if os(macOS)
let platformColor = NSColor(color)
#else
let platformColor = UIColor(color)
#endif
        let isDark = platformColor.isDark
        ZStack {
            Circle()
                .fill(color)
                .overlay(
                    Circle()
                        .stroke(.primary, lineWidth: 1)
                )
                .frame(width: 20, height: 20)

            if !allColorsMatch {
                Text(label)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(isDark ? .white : .black)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ColorStack(mainColor: .black, secondaryColor: .white, accentColor: .gray)
}
