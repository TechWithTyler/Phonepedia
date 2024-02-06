//
//  PhoneImageUnavailableView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/21/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneImageUnavailableView: View {

    var body: some View {
        ContentUnavailableView {
            Text("Phone image unavailable")
                .font(.largeTitle)
        }
    }

}

#Preview {
    PhoneImageUnavailableView()
}
