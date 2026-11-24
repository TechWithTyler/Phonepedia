//
//  CasingTypePickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/22/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

import SwiftUI

struct CasingTypePickerItems: View {
    var body: some View {
        Text("Solid").tag(0)
        Divider()
        Text("Transparent (Tinted)").tag(1)
        Text("Transparent (Clear)").tag(2)
    }
}

#Preview {
    CasingTypePickerItems()
}
