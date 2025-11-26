//
//  SilentModeInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/29/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct SilentModeInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("During silent mode, the ringer will be muted. Silent mode can be set on a daily schedule or manually set to last for a certain number of hours, depending on the phone.\nOn some phones, the key tone/confirmation tone/error tone and/or answering system call screening will also be muted, and the answering system will turn on.\nOn some cordless phones, silent mode is a system-wide setting, so turning it on for the base or one handset/deskset will turn it on for all handsets/desksets/the base.")
    }

}

// MARK: - Preview

#Preview {
    SilentModeInfoView()
}
