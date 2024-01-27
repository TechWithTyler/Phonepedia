//
//  PhoneButtonLegendItem.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 1/25/24.
//  Copyright © 2024 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneButtonLegendItem: View {
    
    enum PhoneButtonDescription: String {
        case talk
        case home
        case cell
        case off
        case speakerphone
    }
    
    var button: PhoneButtonDescription
    
    var colorLayer: Int
    
    init(button: PhoneButtonDescription, colorLayer: Int) {
        self.button = button
        self.colorLayer = colorLayer
    }
    
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
    
    var body: some View {
        HStack {
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
        }
    }
    
    @ViewBuilder
    var talkButton: some View {
        Label("Talk", systemImage: "phone.fill")
            .foregroundStyle(talkButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(talkButtonBackgroundColor)
            )
    }
    
    @ViewBuilder
    var homeButton: some View {
        Label("Home", systemImage: "house.fill")
            .foregroundStyle(talkButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(talkButtonBackgroundColor)
            )
    }
    
    @ViewBuilder
    var cellButton: some View {
        Label("Cell", systemImage: "antenna.radiowaves.left.and.right")
            .foregroundStyle(cellButtonForegroundColor)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    var offButton: some View {
        Label("Off", systemImage: "phone.down.fill")
            .foregroundStyle(offButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(offButtonBackgroundColor)
            )
    }
    
    @ViewBuilder
    var speakerphoneButton: some View {
        Label("Speakerphone", systemImage: "speaker.fill")
            .foregroundStyle(speakerphoneButtonForegroundColor)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(speakerphoneButtonBackgroundColor)
            )
    }
    
}

#Preview {
    PhoneButtonLegendItem(button: .talk, colorLayer: 0)
}
