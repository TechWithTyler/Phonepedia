//
//  ChargingDirectionPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/29/24.
//  Copyright © 2024 SheftApps. All rights reserved.
//

import SwiftUI

struct ChargingDirectionPickerItems: View {
    var body: some View {
        Text("Face-Forward Stand Up").tag(0)
        Text("Face-Up Lean Back").tag(1)
        Text("Face-Up Lay Down").tag(2)
        Divider()
        Text("Face-Backward Stand Up").tag(3)
        Text("Face-Down Lean Back").tag(4)
        Text("Face-Down Lay Down").tag(5)
        Divider()
        Text("Face-Forward Stand Up or Face-Down Lay Down").tag(6)
        Text("Reversible Handset").tag(7)
    }
}

#Preview {
    ChargingDirectionPickerItems()
}
