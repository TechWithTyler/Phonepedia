//
//  OneTouchEmergencyCallingInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 3/5/25.
//  Copyright © 2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct OneTouchEmergencyCallingInfoView: View {

    var body: some View {
        InfoText("One-touch emergency calling allows you to quickly call emergency services or a sequence of emergency contacts by pressing a single button.\nOn cordless phones with intercom and the \"call in sequence\" approach, each handset/base/pendant is called in sequence, then each emergency number is called in sequence if no handset/base/pendant answers. The phone stops the calling sequence as soon as the call is answered. The emergency contacts can be set up in the phonebook or a dedicated emergency number list.\nFor example, for a 2-handset cordless phone with a phonebook and an emergency call button on the base, handset 1 is called first. If handset 1 doesn't answer, handset 2 is called. If handset 2 doesn't answer, the emergency contacts are called in sequence until the phone has made a certain number of calls (often 5). If the number of emergency contacts is less than the number of calls, the phone will keep calling the same emergency contacts until the call is answered or the phone has made the maximum number of calls.")
    }

}

#Preview {
    OneTouchEmergencyCallingInfoView()
}
