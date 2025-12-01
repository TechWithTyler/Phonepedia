//
//  PhonePlaceInCollectionPicker.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/14/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct PhonePlaceInCollectionPicker: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Body

    var body: some View {
        Picker("Place In Collection", selection: $phone.storageOrSetup) {
            PhoneInCollectionStatusPickerItems()
        }
    }

}

// MARK: - Preview

#Preview {
    PhonePlaceInCollectionPicker(phone: Phone.mockPhone)
}
