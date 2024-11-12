//
//  PhonepediaCommands.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/12/24.
//  Copyright © 2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhonepediaCommands: Commands {

    // MARK: - Menu Commands

    var body: some Commands {
        CommandGroup(replacing: .help) {
            Button("\(appName!) Help") {
                showHelp()
            }
                .keyboardShortcut("?", modifiers: .command)
        }
    }

}
