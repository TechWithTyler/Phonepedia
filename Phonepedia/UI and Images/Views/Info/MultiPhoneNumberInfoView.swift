//
//  MultiPhoneNumberInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/14/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct MultiPhoneNumberInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("Storing multiple phone numbers per phonebook entry makes it easier to find the number you're looking for, since you don't have to create separate entries for each number. Depending on the phone, each number assigned to a phonebook entry may count as an individual phonebook entry. For example, for a 150-entry phonebook where 3 phone numbers can be assigned per entry, if you assigned 3 phone numbers for all of your 150 entries, you can only save 50 individual entries, each with 3 numbers. Doing it this way allows compatibility with handsets which can only display a single number per entry at a time.")
    }

}

// MARK: - Preview

#Preview {
    MultiPhoneNumberInfoView()
}
