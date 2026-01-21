//
//  SettingsView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/6/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct SettingsView: View {

    // MARK: - Properties - Dialog Manager

    @StateObject var dialogManager = DialogManager()

    // MARK: - Properties - Dismiss Action

    #if !os(macOS)
    @Environment(\.dismiss) var dismiss
    #endif

    // MARK: - Body

    var body: some View {
#if os(macOS)
        // macOS settings window
            TabView(selection: $dialogManager.selectedSettingsPage) {
                Tab(value: SettingsPage.display) {
                    SAMVisualEffectViewSwiftUIRepresentable(activeState: .active) {
                        DisplaySettingsPageView()
                    }
                    .frame(width: 500, height: 500)
                    .formStyle(.grouped)
                } label: {
                    Label(SettingsPage.display.title, systemImage: SettingsPage.Icons.display.rawValue)
                }
                Tab(value: SettingsPage.newPhones) {
                    SAMVisualEffectViewSwiftUIRepresentable(activeState: .active) {
                        NewPhonesSettingsPageView()
                    }
                    .frame(width: 500, height: 200)
                    .formStyle(.grouped)
                } label: {
                    Label(SettingsPage.newPhones.title, systemImage: SettingsPage.Icons.newPhones.rawValue)
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
                            .navigationTitle(SettingsPage.display.title)
                    } label: {
                        Label(SettingsPage.display.title, systemImage: SettingsPage.Icons.display.rawValue)
                    }
                    NavigationLink {
                        NewPhonesSettingsPageView()
                            .navigationTitle(SettingsPage.newPhones.title)
                    } label: {
                        Label(SettingsPage.newPhones.title, systemImage: SettingsPage.Icons.newPhones.rawValue)
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
