//
//  SettingsPage.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/6/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import Foundation

// A page in Settings.
enum SettingsPage : String {

    // MARK: - Settings Page Icons Enum

    enum Icons: String {

        case display = "textformat.size"

        case newPhones = "phone.badge.plus"

    }

    // MARK: - Settings Page Enum Cases

    case display

    case newPhones = "New Phones"

    // MARK: - Settings Page Title

    var title: String {
        return rawValue.capitalized
    }

}
