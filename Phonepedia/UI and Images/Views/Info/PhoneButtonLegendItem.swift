//
//  PhoneButtonLegendItem.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/25/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct PhoneButtonLegendItem: View {

    // MARK: - Phone Button Description Enum

    enum PhoneButtonDescription: String {

        // Talk (often called Home on Bluetooth cell phone linking-capable models with physical line buttons)
        case talk, home

        // Cell
        case cell

        // Off
        case off

        // Speakerphone
        case speakerphone

        var title: String {
            switch self {
                case .speakerphone: return "Speaker"
                default:
                    return rawValue.capitalized
            }
        }

    }

    // MARK: - Properties - Phone Button Description

    // The button example to show.
    var button: PhoneButtonDescription

    // MARK: - Properties - Integers

    // The layer of the button to color.
    var colorLayer: Int

    // MARK: - Properties - Floats

    // The corner radius of background-colored button examples
    var backgroundColorCornerRadius: CGFloat = 5

    // MARK: - Properties - Colors

    // The foreground color of the talk button.
    var talkButtonForegroundColor: Color {
        switch colorLayer {
            case 1, 3:
                return .green.opacity(0.75)
            default:
                return .primary
        }
    }

    // The background color of the talk button.
    var talkButtonBackgroundColor: Color {
        switch colorLayer {
            case 2, 4:
                return .green.opacity(0.75)
            default:
                return .clear
        }
    }

    // The foreground color of the cell button.
    var cellButtonForegroundColor: Color {
        switch colorLayer {
            case 1, 3:
                return .blue.opacity(0.75)
            default:
                return .primary
        }
    }

    // The background color of the cell button.
    var cellButtonBackgroundColor: Color {
        switch colorLayer {
            case 2, 4:
                return .blue.opacity(0.75)
            default:
                return .clear
        }
    }

    // The foreground color of the off button.
    var offButtonForegroundColor: Color {
        switch colorLayer {
            case 1, 3:
                return .red.opacity(0.75)
            default:
                return .primary
        }
    }

    // The background color of the off button.
    var offButtonBackgroundColor: Color {
        switch colorLayer {
            case 2, 4:
                return .red.opacity(0.75)
            default:
                return .clear
        }
    }

    // The foreground color of the speakerphone button.
    var speakerphoneButtonForegroundColor: Color {
        switch colorLayer {
            case 1:
                return .orange.opacity(0.75)
            default:
                return .primary
        }
    }

    // The background color of the speakerphone button.
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
            Text("\(button.title) Button Label Example:")
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
        .dynamicTypeSize(.medium)

    }

    // MARK: - Talk/Home Button

    @ViewBuilder
    var talkButton: some View {
        Label(PhoneButtonDescription.talk.title, systemImage: "phone.fill")
            .labelStyle(.topIconBottomTitle)
            .foregroundStyle(talkButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: backgroundColorCornerRadius)
                    .fill(talkButtonBackgroundColor)
            )
    }

    @ViewBuilder
    var homeButton: some View {
        Label(PhoneButtonDescription.home.title, systemImage: "house.fill")
            .labelStyle(.topIconBottomTitle)
            .foregroundStyle(talkButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: backgroundColorCornerRadius)
                    .fill(talkButtonBackgroundColor)
            )
    }

    // MARK: - Cell Button

    @ViewBuilder
    var cellButton: some View {
        Label(PhoneButtonDescription.cell.title, systemImage: "antenna.radiowaves.left.and.right")
            .labelStyle(.topIconBottomTitle)
            .foregroundStyle(cellButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: backgroundColorCornerRadius)
                    .fill(cellButtonBackgroundColor)
            )
    }

    // MARK: - Off Button

    @ViewBuilder
    var offButton: some View {
        Label(PhoneButtonDescription.off.title, systemImage: "phone.down.fill")
            .labelStyle(.topIconBottomTitle)
            .foregroundStyle(offButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: backgroundColorCornerRadius)
                    .fill(offButtonBackgroundColor)
            )
    }

    // MARK: - Speakerphone Button

    @ViewBuilder
    var speakerphoneButton: some View {
        Label(PhoneButtonDescription.speakerphone.title, systemImage: "speaker.fill")
            .labelStyle(.topIconBottomTitle)
            .foregroundStyle(speakerphoneButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: backgroundColorCornerRadius)
                    .fill(speakerphoneButtonBackgroundColor)
            )
    }

}

// MARK: - Preview

#Preview {
    PhoneButtonLegendItem(button: .talk, colorLayer: 0)
}
