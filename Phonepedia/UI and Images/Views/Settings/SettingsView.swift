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

    // MARK: - Properties - Dismiss Action

    #if !os(macOS)
    @Environment(\.dismiss) var dismiss
    #endif

    // MARK: - Properties - Integers

    @AppStorage(UserDefaults.KeyNames.defaultAnalogPhoneConnectedToSelection) var defaultAnalogPhoneConnectedToSelection: Int = 2

    @AppStorage(UserDefaults.KeyNames.defaultAcquisitionMethod) var defaultAcquisitionMethod: Int = 0


    // MARK: - Body

    var body: some View {
        #if os(macOS)
        SAMVisualEffectViewSwiftUIRepresentable {
            settingsView
        }
        .frame(width: 500)
        #else
        NavigationStack {
            settingsView
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
                .navigationTitle("Settings")
        }
        #endif
    }

    // MARK: - Settings Content

    @ViewBuilder
    var settingsView: some View {
        Form {
            Section {
                PhoneListDetailOptions()
            } header: {
                Text("Phone List Detail")
            } footer: {
                Text("If \"Show Phone Colors\" is turned on, colored circles will be displayed in the phone list representing a phone's main and secondary colors.\nIf \"Highlight Handset Number Digit\" is turned on and one of the digits in a phone's model number is specified as indicating the number of included cordless handsets, that digit will be highlighted in the phone list.")
            }
            Section {
                Picker("\"Connected To\" Selection For Analog Phones", selection: $defaultAnalogPhoneConnectedToSelection) {
                    AnalogPhoneConnectedToPickerItems()
                }
                Picker("Default \"How I Got It\" Selection", selection: $defaultAcquisitionMethod) {
                    AcquisitionMethodPickerItems()
                }
            } header: {
                Text("New Phones")
            } footer: {
                Text("These options specify the default selections for new phones.")
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

// MARK: - Preview

#Preview {
    SettingsView()
}
