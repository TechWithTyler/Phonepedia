//
//  SoftKeyExplanationView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 8/2/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct SoftKeyExplanationView: View {

    // MARK: - Properties - System Theme

    @Environment(\.colorScheme) var systemTheme

    // MARK: - Properties - Strings

    enum SoftKeyPlacement: String {
        
        case bottom = "bottom"
        
        case left = "left-side"
        
        case right = "right-side"
        
    }
    
    enum SoftKeyMarking: String {
        
        case none = "no marking"
        
        case dot = "a dot"
        
        case dash = "a dash"
        
    }
    
    enum SoftKeyTextCase: String {
        
        case capitalized, uppercase
        
    }

    // MARK: - Body

    var body: some View {
        InfoText("Soft keys are unlabeled buttons which have different functions displayed next to or above them on the display depending on what menu or screen is displayed. This helps to reduce the number of labeled buttons. The term \"soft key\" is used since the labels for these buttons depend on the current state of the phone's software. When nothing is displayed next to or above a soft key, it has no function at this time.")
        HStack {
            Spacer()
            VStack {
                Text("Examples of soft key designs")
                ConditionalHVStack {
                    VStack {
                        Text("MENU")
                        Image(systemName: "minus.rectangle")
                            .font(.system(size: 24))
                    }
                    .dynamicTypeSize(.medium)
                    .frame(width: 60)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(softKeyAccessibilityDescription(placement: .bottom, marking: .dash, textCase: .uppercase, hasTextBackground: false))
                    Divider()
                    VStack {
                        Text("MENU")
                        Image(systemName: "dot.square")
                            .font(.system(size: 24))
                    }
                    .dynamicTypeSize(.medium)
                    .frame(width: 60)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(softKeyAccessibilityDescription(placement: .bottom, marking: .dot, textCase: .uppercase, hasTextBackground: false))
                    Divider()
                    VStack {
                        Text("MENU")
                            .foregroundStyle(systemTheme == .dark ? .black : .white)
                            .background(
                                Rectangle()
                                    .fill(systemTheme == .dark ? .white : .black)
                            )
                        Image(systemName: "minus.rectangle")
                            .font(.system(size: 24))
                    }
                    .dynamicTypeSize(.medium)
                    .frame(width: 60)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(softKeyAccessibilityDescription(placement: .bottom, marking: .dash, textCase: .uppercase, hasTextBackground: true))
                    Divider()
                    VStack {
                        HStack {
                            Text("Menu")
                            Image(systemName: "arrow.turn.right.down")
                        }
                        Image(systemName: "rectangle")
                            .font(.system(size: 24))
                    }
                    .dynamicTypeSize(.medium)
                    .frame(width: 80)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(softKeyAccessibilityDescription(placement: .bottom, marking: .none, textCase: .capitalized, hasTextBackground: false))
                    Divider()
                    HStack {
                        Text("Concierge")
                        Image(systemName: "minus.rectangle")
                            .font(.system(size: 24))
                    }
                    .dynamicTypeSize(.medium)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(softKeyAccessibilityDescription(placement: .right, marking: .dash, textCase: .capitalized, hasTextBackground: false))
                    Divider()
                    HStack {
                        Image(systemName: "minus.rectangle")
                            .font(.system(size: 24))
                        Text("Messages")
                    }
                    .dynamicTypeSize(.medium)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(softKeyAccessibilityDescription(placement: .left, marking: .dash, textCase: .capitalized, hasTextBackground: false))
                }
            }
            Spacer()
        }
    }

    // MARK: - Soft Key Accessibility Description

    // This method returns an accessibility description based on the given soft key placement, marking, text case, and background descriptions.
    func softKeyAccessibilityDescription(placement: SoftKeyPlacement, marking: SoftKeyMarking, textCase: SoftKeyTextCase, hasTextBackground: Bool) -> String {
        return "Example of a \(placement.rawValue) soft key with \(marking.rawValue) on it and \(textCase) text \(hasTextBackground ? "on a filled background" : "on no background") \(placement == .bottom ? "above" : "next to") it on the display"
    }
    
}

// MARK: - Preview

#Preview {
    SoftKeyExplanationView()
}
