//
//  HandsetNumberDigitView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct HandsetNumberDigitView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Properties - Arrays

    // The phone's model number as an array of characters.
    var modelNumberCharacters: [Character] {
        return Array(phone.model)
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            Text("Digit Representing Number of Included Cordless Devices")
                .lineLimit(nil)
            Picker("Digit Represents", selection: $phone.handsetNumberDigitRepresents) {
                Text("Included Cordless Devices").tag(0)
                Text("1 + Additional Cordless Devices").tag(1)
            }
            .disabled(phone.handsetNumberDigit == -1)
            .onChange(of: phone.handsetNumberDigitRepresents) { oldValue, newValue in
                phone.handsetNumberDigitRepresentsChanged(oldValue: oldValue, newValue: newValue)
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<modelNumberCharacters.count, id: \.self) { index in
                        digit(at: index)
                    }
                    Divider()
                    Button("None") {
                        phone.deselectHandsetNumberDigit()
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
        InfoText("The selected digit will be highlighted or underlined in the model number in the phone list. If the last \"+\" or \"-\" is selected, and all the following characters are digits, they'll be highlighted/underlined. Select \"None\" if none of the digits in the model number are the number of included cordless handsets.")
    }

    // MARK: - Digit At Index

    @ViewBuilder
    func digit(at index: Int) -> some View {
        let character = modelNumberCharacters[index]
        // If the character is a number, display it as a button.
        if let newDigitStringAsInt = Int(String(character)) {
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
            let character = String(modelNumberCharacters[index])
            if phone.modelNumberEndsInDashOrPlusFollowedByDigits && (character == "+" || character == "-") {
                    Button(character) {
                        setHandsetNumberDigit(to: -1, at: index)
                    }
                    .tint(phone.handsetNumberDigitIndex == index ? .accentColor.mix(with: .primary, by: 0.25) : .primary)
                    .bold(phone.handsetNumberDigitIndex == index)
                    .underline(phone.handsetNumberDigitIndex == index, color: .primary)
            } else {
                // If the character isn't a number, display it as text.
                Text(character)
                    .padding(4)
            }
        }
    }

    // MARK: - Set Handset Number Digit

    func setHandsetNumberDigit(to newDigit: Int, at index: Int) {
        // 1. If newDigit is -1, the last dash or plus in the model number was selected. Make sure the digits that follow (e.g. 1 and 2), joined as a String (e.g. 12) then converted to an Int, make up a number less than or equal to maxNumber.
        let newNumberOfIncludedCordlessHandsets: Int
        if newDigit == -1 {
            let maxNumber = phone.handsetNumberDigitRepresents == 1 ? 29 : 30
            guard let afterDash = phone.model.components(separatedBy: ["-", "+"]).last, let digits = Int(afterDash), digits <= maxNumber else { return }
            phone.handsetNumberDigitRepresents = modelNumberCharacters[index] == "+" ? 1 : 0
            newNumberOfIncludedCordlessHandsets = digits == 0 ? 1 : digits
        } else {
            newNumberOfIncludedCordlessHandsets = newDigit == 0 ? 1 : newDigit
        }
        // 2. Set the number of included cordless handsets to the value corresponding to the new digit. For example, if the 2 after the dash in M123-2 is selected, the number of included cordless handsets will be set to 2. If the selected digit is 0, set it to 1.
        phone.numberOfIncludedCordlessHandsets = phone.handsetNumberDigitRepresents == 1 ? newNumberOfIncludedCordlessHandsets + 1 : newNumberOfIncludedCordlessHandsets
        // 2. Set the handset number digit and index to the new digit and index.
        phone.handsetNumberDigit = newDigit
        phone.handsetNumberDigitIndex = index
    }

}

// MARK: - Preview

#Preview {
    HandsetNumberDigitView(phone: Phone(brand: "Panasonic", model: "KX-TG1032"))
}
