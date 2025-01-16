//
//  DisplaySettingsPageView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/6/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct DisplaySettingsPageView: View {

    // MARK: - Properties - Sample Phone

    // The phone to use for previewing the phone list detail settings.
    var samplePhone: Phone {
        // 1. Create a mock phone and cordless handset.
        let phone = Phone(brand: Phone.mockBrand, model: Phone.mockModel)
        let handset = CordlessHandset(brand: Phone.mockBrand, model: CordlessHandset.mockModel, mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 190, accentColorGreen: 190, accentColorBlue: 190)
        // 2. Duplicate the mock cordless handset so the mock phone has 2 mock cordless handsets.
        let secondHandset = handset.duplicate()
        // 3. Set the mock phone's properties.
        phone.baseMainColorRed = 0
        phone.baseMainColorGreen = 0
        phone.baseMainColorBlue = 0
        phone.baseSecondaryColorRed = 0
        phone.baseSecondaryColorGreen = 0
        phone.baseSecondaryColorBlue = 0
        phone.baseAccentColorRed = 190
        phone.baseAccentColorGreen = 190
        phone.baseAccentColorBlue = 190
        // 4. Add the handsets to the mock phone.
        phone.cordlessHandsetsIHave.append(handset)
        phone.cordlessHandsetsIHave.append(secondHandset)
        // 5. Return the mock phone.
        return phone
    }

    // MARK: - Properties - Doubles

    @AppStorage(UserDefaults.KeyNames.phoneDescriptionTextSize) var phoneDescriptionTextSize: Double = SATextViewMinFontSize

    // MARK: - Body

    var body: some View {
        Form {
            Section {
                TextSizeSlider(labelText: "Phone Description Text Size", textSize: $phoneDescriptionTextSize, previewText: phoneDescriptionSampleText)
            }
            Section("Phone List Detail") {
                PhoneListDetailOptions()
            }
            Section("Phone List Display Example") {
                List {
                    PhoneRowView(phone: samplePhone)
                }
            }
        }
        .formStyle(.grouped)
    }

}

// MARK: - Preview

#Preview {
    DisplaySettingsPageView()
}
