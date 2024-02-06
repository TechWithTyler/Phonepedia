//
//  SoftKeyExplanationView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 8/2/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct SoftKeyExplanationView: View {
    
    // (placement: SoftKeyPlacement, marking: SoftKeyMarking, textStyle: SoftKeyTextStyle)
    
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
    
    var body: some View {
        InfoText("Soft keys are unlabeled buttons which have different functions displayed next to or above them on the display depending on what menu or screen is displayed. When nothing is displayed next to or above a soft key, it has no function at this time.")
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
                    .frame(width: 60)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(softKeyAccessibilityDescription(placement: .bottom, marking: .dash, textCase: .uppercase, hasTextBackground: false))
                    Divider()
                    VStack {
                        Text("MENU")
                        Image(systemName: "dot.square")
                            .font(.system(size: 24))
                    }
                    .frame(width: 60)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(softKeyAccessibilityDescription(placement: .bottom, marking: .dot, textCase: .uppercase, hasTextBackground: false))
                    Divider()
                    VStack {
                        Text("MENU")
                            .foregroundStyle(.white)
                            .background(
                                Rectangle()
                                    .fill(.black)
                            )
                        Image(systemName: "minus.rectangle")
                            .font(.system(size: 24))
                    }
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
                    .frame(width: 80)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(softKeyAccessibilityDescription(placement: .bottom, marking: .none, textCase: .capitalized, hasTextBackground: false))
                    Divider()
                    HStack {
                        Text("Concierge")
                        Image(systemName: "minus.rectangle")
                            .font(.system(size: 24))
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(softKeyAccessibilityDescription(placement: .right, marking: .dash, textCase: .capitalized, hasTextBackground: false))
                    Divider()
                    HStack {
                        Image(systemName: "minus.rectangle")
                            .font(.system(size: 24))
                        Text("Messages")
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(softKeyAccessibilityDescription(placement: .left, marking: .dash, textCase: .capitalized, hasTextBackground: false))
                }
            }
            Spacer()
        }
    }
    
    func softKeyAccessibilityDescription(placement: SoftKeyPlacement, marking: SoftKeyMarking, textCase: SoftKeyTextCase, hasTextBackground: Bool) -> String {
        return "Example of a \(placement.rawValue) soft key with \(marking.rawValue) on it and \(textCase) text \(hasTextBackground ? "on a filled background" : "on no background") \(placement == .bottom ? "above" : "next to") it on the display"
    }
    
}

#Preview {
    SoftKeyExplanationView()
}
