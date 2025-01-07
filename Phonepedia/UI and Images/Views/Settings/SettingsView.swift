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

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Properties - Dismiss Action

    #if !os(macOS)
    @Environment(\.dismiss) var dismiss
    #endif

    // MARK: - Body

    var body: some View {
#if os(macOS)
        // macOS settings window
        SAMVisualEffectViewSwiftUIRepresentable {
            TabView(selection: $dialogManager.selectedSettingsPage) {
                Tab(value: SettingsPage.display) {
                    SAMVisualEffectViewSwiftUIRepresentable {
                        DisplaySettingsPageView()
                    }
                    .frame(width: 500, height: 500)
                    .formStyle(.grouped)
                } label: {
                    Label(SettingsPage.display.rawValue.capitalized, systemImage: SettingsPage.Icons.display.rawValue)
                }
                Tab(value: SettingsPage.newPhones) {
                    SAMVisualEffectViewSwiftUIRepresentable {
                        NewPhonesSettingsPageView()
                    }
                    .frame(width: 500, height: 200)
                    .formStyle(.grouped)
                } label: {
                    Label(SettingsPage.newPhones.rawValue.capitalized, systemImage: SettingsPage.Icons.newPhones.rawValue)
                }
            }
        }
        .toggleStyle(.stateLabelCheckbox(stateLabelPair: .yesNo))
#else
        // iOS/visionOS settings page
        NavigationStack {
            Form {
                Section {
                    NavigationLink {
                        DisplaySettingsPageView()
                            .navigationTitle(SettingsPage.display.rawValue.capitalized)
                    } label: {
                        Label(SettingsPage.display.rawValue.capitalized, systemImage: SettingsPage.Icons.display.rawValue)
                    }
                    NavigationLink {
                        NewPhonesSettingsPageView()
                            .navigationTitle(SettingsPage.newPhones.rawValue.capitalized)
                    } label: {
                        Label(SettingsPage.newPhones.rawValue.capitalized, systemImage: SettingsPage.Icons.newPhones.rawValue)
                    }
                }
                Section {
                    Button("Help…", systemImage: "questionmark.circle") {
                        showHelp()
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.automatic)
            .formStyle(.grouped)
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .toggleStyle(.stateLabelCheckbox(stateLabelPair: .yesNo))
        .pickerStyle(.navigationLink)
#endif
    }

}

// MARK: - Preview

#Preview {
    SettingsView()
}
