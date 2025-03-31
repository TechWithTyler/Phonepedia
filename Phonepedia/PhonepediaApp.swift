//
//  PhonepediaApp.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI
import SwiftData

@main
struct PhonepediaApp: App {
    
    @ObservedObject var photoViewModel = PhonePhotoViewModel()

    @ObservedObject var dialogManager = DialogManager()

    @ObservedObject var audioManager = AudioManager()

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
                .environmentObject(photoViewModel)
                .environmentObject(dialogManager)
                .environmentObject(audioManager)
            #if os(macOS)
                .frame(minWidth: 1000)
            #endif
        }
        .commands {
            PhonepediaCommands(dialogManager: dialogManager)
        }
        #if os(macOS)
        Settings {
            SettingsView()
                .environmentObject(dialogManager)
        }
        #endif
    }
}
