//
//  PhonebookGroupInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/29/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhonebookGroupInfoView: View {

    var body: some View {
        InfoText("Phonebook groups allow you to organize your phonebook (e.g. Family, Friends, Work). You can search for entries by group and, depending on the phone, assign a ringtone to each group.\nBluetooth cell phone linking-capable phones which store transferred phonebook entries to the home phonebook may have groups called Cell 1, Cell 2, and so on. In this case, transferred phonebook entries will be saved to the group corresponding to which cell line the cell phone is paired to.")
    }

}

#Preview {
    PhonebookGroupInfoView()
}
