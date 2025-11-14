//
//  HandsetPlaceInCollectionPicker.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/14/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct HandsetPlaceInCollectionPicker: View {

    // MARK: - Properties - Handset

    @Bindable var handset: CordlessHandset

    // MARK: - Body

    var body: some View {
        Picker("Place In Collection", selection: $handset.storageOrSetup) {
            PhoneInCollectionStatusPickerItems()
        }
    }

}

// MARK: - Preview

#Preview {
    HandsetPlaceInCollectionPicker(handset: CordlessHandset.mockHandset)
}
