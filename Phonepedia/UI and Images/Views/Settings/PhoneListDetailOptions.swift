//
//  PhoneListDetailOptions.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/9/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneListDetailOptions: View {

    // MARK: - Properties - Booleans

    @AppStorage(UserDefaults.KeyNames.showPhoneTypeInList) var showPhoneTypeInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showPhoneActiveStatusInList) var showPhoneActiveStatusInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.highlightHandsetNumberDigitInList) var highlightHandsetNumberDigitInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showNumberOfCordlessHandsetsInList) var showNumberOfCordlessHandsetsInList: Bool = true

    // MARK: - Body

    var body: some View {
        Toggle("Show Phone Type", isOn: $showPhoneTypeInList)
        Toggle("Show Phone Active Status", isOn: $showPhoneActiveStatusInList)
        Toggle("Show Number Of Cordless Handsets", isOn: $showNumberOfCordlessHandsetsInList)
        Toggle("Highlight Handset Number Digit", isOn: $highlightHandsetNumberDigitInList)
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
        PhoneListDetailOptions()
    }
}
