//
//  PhoneInCollectionStatusPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 7/15/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneInCollectionStatusPickerItems: View {

    var body: some View {
        Text("Active (Working)").tag(0)
        Text("Active (Broken)").tag(1)
        Divider()
        Text("Shelf (Working)").tag(2)
        Text("Shelf (Broken)").tag(3)
        Text("Box/Bin (Working)").tag(4)
        Text("Box/Bin (Broken)").tag(5)
    }

}
