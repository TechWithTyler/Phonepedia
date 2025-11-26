//
//  PhoneButtonLegendItem.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/25/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct PhoneButtonLegendItem: View {

    // MARK: - Phone Button Description Enum

    enum PhoneButtonDescription: String {

        case talk, home

        case cell

        case off

        case speakerphone

    }

    // MARK: - Properties - Phone Button Description

    var button: PhoneButtonDescription

    // MARK: - Properties - Integers

    var colorLayer: Int

    // MARK: - Properties - Colors

    var talkButtonForegroundColor: Color {
        switch colorLayer {
        case 1:
            return .green.opacity(0.75)
        default:
            return .primary
        }
    }
    
    var talkButtonBackgroundColor: Color {
        switch colorLayer {
        case 2:
            return .green.opacity(0.75)
        default:
            return .clear
        }
    }
    
    var cellButtonForegroundColor: Color {
        return .blue.opacity(0.75)
    }
    
    var offButtonForegroundColor: Color {
        switch colorLayer {
        case 1:
            return .red.opacity(0.75)
        default:
            return .primary
        }
    }
    
    var offButtonBackgroundColor: Color {
        switch colorLayer {
        case 2:
            return .red.opacity(0.75)
        default:
            return .clear
        }
    }
    
    var speakerphoneButtonForegroundColor: Color {
        switch colorLayer {
        case 1:
            return .orange.opacity(0.75)
        default:
            return .primary
        }
    }
    
    var speakerphoneButtonBackgroundColor: Color {
        switch colorLayer {
        case 2:
            return .orange.opacity(0.75)
        default:
            return .clear
        }
    }

    // MARK: - Initialization

    init(button: PhoneButtonDescription, colorLayer: Int) {
        self.button = button
        self.colorLayer = colorLayer
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(button.rawValue.capitalized) Button Label Example:")
            switch button {
            case .talk:
                talkButton
            case .cell:
                cellButton
            case .home:
                homeButton
            case .off:
                offButton
            case .speakerphone:
                speakerphoneButton
            }
            if colorLayer > 0 {
                Text("The \(button.rawValue) button color scheme shown is an example--your handset may differ.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }

    // MARK: - Talk/Home Button

    @ViewBuilder
    var talkButton: some View {
        Label(PhoneButtonDescription.talk.rawValue.capitalized, systemImage: "phone.fill")
            .labelStyle(.topIconBottomTitle)
            .foregroundStyle(talkButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(talkButtonBackgroundColor)
            )
    }
    
    @ViewBuilder
    var homeButton: some View {
        Label(PhoneButtonDescription.home.rawValue.capitalized, systemImage: "house.fill")
            .labelStyle(.topIconBottomTitle)
            .foregroundStyle(talkButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(talkButtonBackgroundColor)
            )
    }

    // MARK: - Cell Button

    @ViewBuilder
    var cellButton: some View {
        Label(PhoneButtonDescription.cell.rawValue.capitalized, systemImage: "antenna.radiowaves.left.and.right")
            .labelStyle(.topIconBottomTitle)
            .foregroundStyle(cellButtonForegroundColor)
            .padding(.horizontal)
    }

    // MARK: - Off Button

    @ViewBuilder
    var offButton: some View {
        Label(PhoneButtonDescription.off.rawValue.capitalized, systemImage: "phone.down.fill")
            .labelStyle(.topIconBottomTitle)
            .foregroundStyle(offButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(offButtonBackgroundColor)
            )
    }

    // MARK: - Speakerphone Button

    @ViewBuilder
    var speakerphoneButton: some View {
        Label("Speakerphone", systemImage: "speaker.fill")
            .labelStyle(.topIconBottomTitle)
            .foregroundStyle(speakerphoneButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(speakerphoneButtonBackgroundColor)
            )
    }
    
}

// MARK: - Preview

#Preview {
    PhoneButtonLegendItem(button: .talk, colorLayer: 0)
}
