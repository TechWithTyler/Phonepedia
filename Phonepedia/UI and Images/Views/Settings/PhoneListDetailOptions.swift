//
//  PhoneListDetailOptions.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/9/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneListDetailOptions: View {

    // MARK: - Properties - Booleans

    var menu: Bool = false

    @AppStorage(UserDefaults.KeyNames.showPhoneTypeInList) var showPhoneTypeInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showPhoneActiveStatusInList) var showPhoneActiveStatusInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.highlightHandsetNumberDigitInList) var highlightHandsetNumberDigitInList: Int = 2

    @AppStorage(UserDefaults.KeyNames.showNumberOfCordlessHandsetsInList) var showNumberOfCordlessHandsetsInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showPhoneColorsInList) var showPhoneColorsInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showYearsInList) var showYearsInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showFrequencyInList) var showFrequencyInList: Bool = true

    // MARK: - Body

    var body: some View {
        Toggle("Show Phone Type", isOn: $showPhoneTypeInList)
        if showPhoneTypeInList {
            Toggle("Show Cordless Phone Frequency", isOn: $showFrequencyInList)
        }
        Toggle("Show Phone Active Status", isOn: $showPhoneActiveStatusInList)
        Toggle("Show Number Of Cordless Handsets", isOn: $showNumberOfCordlessHandsetsInList)
        if !menu {
            InfoText("If the number of included cordless handsets for a phone is the same as how many you have for that phone, a single cordless handset count is displayed. If you don't have the same number of cordless handsets as the phone comes with, both the included handset count and the \"how many I have\" count will be displayed.")
        }
        Toggle("Show Phone Colors", isOn: $showPhoneColorsInList)
        if !menu {
            InfoText("If both a phone's main and secondary colors are the same, a single colored circle will be displayed. If they're different, the main color is represented by the upper circle and the secondary color is represented by the lower circle.")
        }
        Toggle("Show Release/Acquisition Years", isOn: $showYearsInList)
        Picker("Handset Number Digit Indication", selection: $highlightHandsetNumberDigitInList) {
            Text("Off").tag(0)
            Text("Underline").tag(1)
            Text("Highlight").tag(2)
        }
        if !menu {
            InfoText("If one of the digits of a cordless phone's model number is specified as indicating the number of included cordless handsets (e.g., the 2 after the dash in \(Phone.mockModel) indicating that it has 2 cordless handsets), that digit will be highlighted or underlined in the phone list.")
        }
    }

}

// MARK: - Preview

#Preview("View") {
    Form {
        PhoneListDetailOptions()
    }
    .formStyle(.grouped)
}

#Preview("Menu") {
    Menu("Phone List Detail Options") {
        PhoneListDetailOptions(menu: true)
    }
}
