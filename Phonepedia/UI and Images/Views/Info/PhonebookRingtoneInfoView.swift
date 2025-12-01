//
//  PhonebookRingtoneInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/29/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct PhonebookRingtoneInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("When a ringtone is assigned to a phonebook entry or favorite entry, that ringtone will be used when the entry calls (requires caller ID). When a ringtone is assigned to a phonebook group, that ringtone will be used when any entry in the group calls unless the entry has a ringtone assigned. On analog phones, the main ringtone will be played first before the caller ID is received (unless caller ID is received before the first ring). Some phones will suppress the first ring when at least one phonebook entry has a ringtone assigned, ensuring you only hear that ringtone when that entry calls.\nOn most cordless phones with a shared phonebook, changing an entry/group ringtone on the base or a cordless device changes it for all. If the base/registered cordless devices have different numbers of ringtones, this may cause compatibility issues. For example, if a handset with 20 ringtones chooses tone 16 and another handset only has 10 ringtones, the 10-ringtone handset may glitch out and allow selecting an even higher ringtone number.\nFor phones which support silent mode and silent mode bypass, entries or groups can be selected to break through silent mode so their calls can still ring.\nSome phones have a VIP group/the ability to mark entries as VIPs. VIP entries can be assigned ringtones and be set to break through silent mode.")
    }

}

// MARK: - Preview

#Preview {
    PhonebookRingtoneInfoView()
}
