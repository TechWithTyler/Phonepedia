//
//  HandsetNumberDigitView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetNumberDigitView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Properties - Arrays

    var modelNumber: [Character] {
        return Array(phone.model)
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            Text("Digit Representing Number Of Included Cordless Handsets")
                .lineLimit(nil)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<modelNumber.count, id: \.self) { index in
                        let character = modelNumber[index]
                        // If the character is a number greater than 0, display it as a button.
                        if let newDigitStringAsInt = Int(String(character)), newDigitStringAsInt > 0 {
                            Button(String(character)) {
                                    setHandsetNumberDigit(to: newDigitStringAsInt, at: index)
                            }
                            .tint(phone.handsetNumberDigitIndex == index ? .accentColor.mix(with: .primary, by: 0.25) : .primary)
                            .bold(phone.handsetNumberDigitIndex == index)
                            .underline(phone.handsetNumberDigitIndex == index, color: .primary)
                            .padding(4)
                            #if !os(macOS)
                            .hoverEffect(.highlight)
                            #endif
                            .accessibilityConditionalTrait(.isSelected, condition: phone.handsetNumberDigitIndex == index)
                        } else {
                            // If the character isn't a number greater than 0, display it as text.
                            Text(String(modelNumber[index]))
                                .padding(4)
                        }
                    }
                    Divider()
                    Button("None") {
                        phone.handsetNumberDigit = nil
                        phone.handsetNumberDigitIndex = nil
                    }
                    .tint(phone.handsetNumberDigitIndex == nil ? .accentColor.mix(with: .primary, by: 0.25) : .primary)
                    .bold(phone.handsetNumberDigitIndex == nil)
                    .underline(phone.handsetNumberDigitIndex == nil, color: .primary)
                    .padding(4)
                    #if !os(macOS)
                    .hoverEffect(.highlight)
                    #endif
                    .accessibilityConditionalTrait(.isSelected, condition: phone.handsetNumberDigitIndex == nil)
                }
                .animation(.linear, value: phone.handsetNumberDigitIndex)
                .buttonStyle(.borderless)
            }
        }
        InfoText("The selected digit will be highlighted or underlined in the model number in the phone list. Select \"None\" if none of the digits in the model number are the number of included cordless handsets, the number of included cordless handsets is indicated by 2 digits (e.g., the -12 in M123-12 indicating 12 handsets), or one or more digits of the model number indicates that the phone comes with one handset + X additional handsets (e.g. M123+3 indicating 1 handset + 3 additional handsets).")
    }

    // MARK: - Set Handset Number Digit

    func setHandsetNumberDigit(to newDigit: Int, at index: Int) {
        // 1. Set the number of included cordless handsets to the value corresponding to the new digit. For example, if the 2 after the dash in M123-2 is selected, the number of included cordless handsets will be set to 2.
        phone.numberOfIncludedCordlessHandsets = newDigit
        // 2. Set the handset number digit and index to the new digit and index.
        phone.handsetNumberDigit = newDigit
        phone.handsetNumberDigitIndex = index
    }

}

// MARK: - Preview

#Preview {
    HandsetNumberDigitView(phone: Phone(brand: "Panasonic", model: "KX-TG1032"))
}
