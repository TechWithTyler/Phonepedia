//
//  SpeedDialEntryModeInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/7/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct SpeedDialEntryModeInfoView: View {
    var body: some View {
        InfoText("The speed dial entry mode describes how phonebook entries are saved to speed dial locations and whether they allow numbers to be manually entered. \"Copy\" means the phonebook entry will be copied to the speed dial location, and editing the phonebook entry won't affect the speed dial entry. \"Link\" means the speed dial entry is tied to the corresponding phonebook entry, so editing the phonebook entry will affect the speed dial entry and vice versa, and the speed dial entry will be deleted if the corresponding phonebook entry is deleted.")
    }
}

#Preview {
    SpeedDialEntryModeInfoView()
}
