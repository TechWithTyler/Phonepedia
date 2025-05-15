//
//  MultiEntryDisplayInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/28/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct MultiEntryDisplayInfoView: View {

    var body: some View {
        InfoText("Phones can show either a single entry or multiple entries at a time. Typically, a multi-entry display shows only the names of entries (or phone numbers for entries without names). The detail button/menu item can be used to view the full entry.\n\nOn phones with an up/down/left/right navigation button or joystick, left and right can be used to go to the next or previous page of entries. When viewing a shared list on a handset, the handset loads as many entries as it can display at a time, instead of just one at a time. For example, if 5 entries fit on the display at a time, 5 entries are loaded per page. The entries may load fully, in which case showing the details is instant, or only their names will load, in which case showing the details will have to load the full entry.")
    }

}

#Preview {
    MultiEntryDisplayInfoView()
}
