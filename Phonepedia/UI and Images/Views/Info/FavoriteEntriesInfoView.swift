//
//  FavoriteEntriesInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/29/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct FavoriteEntriesInfoView: View {

    var body: some View {
        InfoText("Favorite entries can be quickly accessed using one-touch dial buttons or a button that displays a favorites list. These entries can not only be dialed quickly but can also show when they last called without having to view the caller ID list. These entries take priority over the phonebook for features like caller ID phonebook match and entry-specific ringtones.")
    }

}

#Preview {
    FavoriteEntriesInfoView()
}
