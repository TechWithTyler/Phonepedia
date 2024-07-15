//
//  PhoneInCollectionStatusPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 7/15/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneInCollectionStatusPickerItems: View {

    var body: some View {
        Text("Active (working)").tag(0)
        Text("Active (broken)").tag(1)
        Divider()
        Text("Shelf (working)").tag(2)
        Text("Shelf (broken)").tag(3)
        Text("Box/Bin (working)").tag(4)
        Text("Box/Bin (broken)").tag(5)
    }

}
