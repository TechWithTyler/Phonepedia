//
//  VoicemailQuickDialInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 7/22/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct VoicemailQuickDialInfoView: View {

    var body: some View {
        InfoText("You can store your voicemail access number (e.g. *99) into the phone and quickly dial it using a button or menu item.\nUsing key 1 as the speed dial key for voicemail dates back to when cell phones allowed you to assign features or contacts to specific dial keys. Tip: If the 1 key has an envelope or tape cassette icon, it can be used to access voicemail.")
    }

}

#Preview {
    VoicemailQuickDialInfoView()
}
