//
//  SettingsView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/6/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct SettingsView: View {

    @AppStorage(UserDefaults.KeyNames.showPhoneTypeInList) var showPhoneTypeInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showPhoneActiveStatusInList) var showPhoneActiveStatusInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.highlightHandsetNumberDigitInList) var highlightHandsetNumberDigitInList: Bool = true

    var body: some View {
        Form {
            Section("Phone List Detail") {
                Toggle("Show Phone Type", isOn: $showPhoneTypeInList)
                Toggle("Show Phone Active Status", isOn: $showPhoneActiveStatusInList)
                Toggle("Highlight Handset Number Digit In List", isOn: $highlightHandsetNumberDigitInList)
                InfoText("If this setting is turned on and one of the digits in a phone's model number is specified as indicating the number of included cordless handsets, that digit will be highlighted in the phone list.")
            }
#if !os(macOS)
            Section {
                Button("Help…", systemImage: "questionmark.circle") {
                    showHelp()
                }
            }
#endif
        }
        .formStyle(.grouped)
    }

}

#Preview {
    SettingsView()
}
