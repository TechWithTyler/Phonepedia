//
//  PhonepediaCommands.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/12/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI
import SheftAppsInternals

struct PhonepediaCommands: Commands {

    // MARK: - Properties - Dialog Manager

    @FocusedObject private var dialogManager: DialogManager?

    // MARK: - Menu Commands

    var body: some Commands {
        if let dialogManager = dialogManager {
            CommandGroup(before: .sidebar) {
                Section {
                    PhoneCountButton()
                        .environmentObject(dialogManager)
                    PhoneCollectionAchievementsButton()
                        .environmentObject(dialogManager)
                    Divider()
                    PhoneTypeDefinitionsButton()
                        .environmentObject(dialogManager)
                }
            }
        }
        CommandGroup(replacing: .help) {
            Button("\(SAAppName) Help") {
                showHelp()
            }
                .keyboardShortcut("?", modifiers: .command)
        }
    }

}
