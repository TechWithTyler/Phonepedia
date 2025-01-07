//
//  NewPhonesSettingsPageView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/6/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct NewPhonesSettingsPageView: View {

    // MARK: - Properties - Integers

    @AppStorage(UserDefaults.KeyNames.defaultAnalogPhoneConnectedToSelection) var defaultAnalogPhoneConnectedToSelection: Int = 2

    @AppStorage(UserDefaults.KeyNames.defaultAcquisitionMethod) var defaultAcquisitionMethod: Int = 0

    var body: some View {
        Form {
            Section {
                Picker("\"Connected To\" Selection For Analog Phones", selection: $defaultAnalogPhoneConnectedToSelection) {
                    AnalogPhoneConnectedToPickerItems()
                }
                Picker("Default \"How I Got It\" Selection", selection: $defaultAcquisitionMethod) {
                    AcquisitionMethodPickerItems()
                }
            } footer: {
                Text("These options specify the default selections for new phones.")
            }
        }
        .formStyle(.grouped)
    }
}

#Preview {
    NewPhonesSettingsPageView()
}
