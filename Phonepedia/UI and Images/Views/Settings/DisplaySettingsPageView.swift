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

    @AppStorage(UserDefaults.KeyNames.phoneDescriptionTextSize) var phoneDescriptionTextSize: Double = SATextViewMinFontSize

    var body: some View {
        Form {
            Section {
                TextSizeSlider(labelText: "Phone Description Text Size", textSize: $phoneDescriptionTextSize, previewText: phoneDescriptionSampleText)
            }
            Section {
                PhoneListDetailOptions()
            } header: {
                Text("Phone List Detail")
            } footer: {
                Text("If \"Show Phone Colors\" is turned on, colored circles will be displayed in the phone list representing a phone's main and secondary colors.\nIf \"Highlight Handset Number Digit\" is turned on and one of the digits in a phone's model number is specified as indicating the number of included cordless handsets, that digit will be highlighted in the phone list.")
            }
        }
        .formStyle(.grouped)
    }

}

#Preview {
    DisplaySettingsPageView()
}
