//
//  PhonebookRingtoneInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/29/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhonebookRingtoneInfoView: View {

    var body: some View {
        InfoText("When a ringtone is assigned to a phonebook entry or favorite entry, that ringtone will be used when the entry calls. When a ringtone is assigned to a phonebook group, that ringtone will be used when any entry in the group calls unless the entry has a ringtone assigned. On analog phones, the main ringtone will be played first before the caller ID is received (unless caller ID is received before the first ring). Some phones will suppress the first ring when at least one phonebook entry has a ringtone assigned.\nFor phones which support silent mode and silent mode bypass, entries or groups can be selected to break through silent mode so their calls can still ring.\nSome phones have a VIP group/the ability to mark entries as VIPs. VIP entries can be assigned ringtones and be set to break through silent mode.")
    }

}

#Preview {
    PhonebookRingtoneInfoView()
}
