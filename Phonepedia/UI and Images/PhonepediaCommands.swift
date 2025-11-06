//
//  PhonepediaCommands.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/12/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct PhonepediaCommands: Commands {

    @FocusedObject private var dialogManager: DialogManager?

    // MARK: - Menu Commands

    var body: some Commands {
        if let dialogManager = dialogManager {
            CommandGroup(before: .sidebar) {
                Section {
                    PhoneCountButton()
                        .environmentObject(dialogManager)
                    PhoneTypeDefinitionsButton()
                        .environmentObject(dialogManager)
                }
            }
        }
        CommandGroup(replacing: .help) {
            Button("\(appName!) Help") {
                showHelp()
            }
                .keyboardShortcut("?", modifiers: .command)
        }
    }

}
