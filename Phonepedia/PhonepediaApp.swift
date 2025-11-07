//
//  PhonepediaApp.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI
import SwiftData

@main
struct PhonepediaApp: App {

    // MARK: - Body

    var body: some Scene {
#if os(iOS) || os(visionOS)
        DocumentGroupLaunchScene {
            NewDocumentButton("New Phone Catalog")
        } background: {
            DocumentLaunchBackgroundView()
        } overlayAccessoryView: { geometry in
            DocumentLaunchPhonesAccessoryView()
        }
#endif
        DocumentGroup(editing: .phonepediaCatalog, migrationPlan: PhonepediaMigrationPlan.self) {
            ContentView()
            #if os(macOS)
                .frame(minWidth: 1000)
            #endif
        }
        .commands {
            PhonepediaCommands()
        }
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
    
}
