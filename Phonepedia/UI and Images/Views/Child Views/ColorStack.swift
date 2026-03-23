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

    // MARK: - Body

    var body: some View {
        VStack {
            colorCircle(for: mainColor)
            if let secondaryColor = secondaryColor {
                colorCircle(for: secondaryColor)
            }
            if let accentColor = accentColor {
                colorCircle(for: accentColor)
            }
        }
    }

    // MARK: - Phone Color Circle

    @ViewBuilder
    func colorCircle(for color: Color) -> some View {
        Circle()
            .fill(color)
                   .overlay(
                       Circle()
                        .stroke(.primary, lineWidth: 1)
                   )
                   .frame(width: 10, height: 10)
    }
}

// MARK: - Preview

#Preview {
    ColorStack(mainColor: .black, secondaryColor: .white, accentColor: .gray)
}
