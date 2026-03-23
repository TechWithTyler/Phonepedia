//
//  DisplaySettingsPageView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/6/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct DisplaySettingsPageView: View {

    // MARK: - Properties - Sample Phone

    // The phone to use for previewing the phone list detail settings.
    var samplePhone: Phone {
        // 1. Create a mock phone and cordless handset.
        let phone = Phone.mockPhone
        let handset = CordlessHandset.mockHandset
        phone.releaseYear = 2014
        phone.acquisitionYear = 2023
        handset.releaseYear = 2014
        handset.acquisitionYear = 2023
        // 2. Duplicate the mock cordless handset so the mock phone has 2 mock cordless handsets.
        let secondHandset = handset.duplicate()
        // 3. Set the mock phone's colors.
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

    @AppStorage(UserDefaults.KeyNames.phoneDescriptionTextSize) var phoneDescriptionTextSize: Double = SATextViewIdealMinFontSize

    // MARK: - Properties - Booleans

    @AppStorage(UserDefaults.KeyNames.showAchievementAlerts) var showAchievementAlerts: Bool = true

    @AppStorage(UserDefaults.KeyNames.useDetailedPhoneImage) var useDetailedPhoneImage: Bool = false

    @AppStorage(UserDefaults.KeyNames.backdropEnabled) var backdropEnabled: Bool = true

    // MARK: - Body

    var body: some View {
        Form {
            Section {
                TextSizeSlider(labelText: "Phone Description Text Size", textSize: $phoneDescriptionTextSize, previewText: phoneDescriptionSampleText)
                HStack {
                    Text("Placeholder Image Style")
                    Spacer()
                    Button {
                        useDetailedPhoneImage = false
                    } label: {
                        VStack {
                            Image(.phone)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Text("Simple")
                            Image(systemName: useDetailedPhoneImage ? "circle" : "checkmark.circle.fill")
                                .animatedSymbolReplacement()
                        }
                    }
                    Button {
                        useDetailedPhoneImage = true
                    } label: {
                        VStack {
                            Image(.phoneDetailedThumbnail)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Text("Detailed")
                            Image(systemName: useDetailedPhoneImage ? "checkmark.circle.fill" : "circle")
                                .animatedSymbolReplacement()
                        }
                    }
                }
                .buttonStyle(.borderless)
                .foregroundStyle(.primary)
                Toggle("Show Achievement Alerts" , isOn: $showAchievementAlerts)
                InfoText("Turn this on to show alerts when unlocking achievements (e.g. getting 10 phones, getting a phone in its release year).")
                Toggle("Enable Backdrop", isOn: $backdropEnabled)
                InfoText("Turn this on to show a large, blurred version of a phone's photo as the detail view background.")
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
