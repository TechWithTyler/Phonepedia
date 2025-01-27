//
//  RingtoneInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 7/15/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct RingtoneInfoView: View {
    var body: some View {
        InfoText("Phones with multiple ringtone choices often have a combination of standard and music/melody ringtones. Standard ringtones include one or more variations of a standard phone ring, and may also include other choices of sounds. Music/melody ringtones add more variety to a phone's ringtone options, but don't follow the ring signal, so the music/melody ringtone may continue to play for a bit after another phone on the same line is answered or the caller hangs up.\nMulti-line phones without selectable ringtones have a different ringtone for each line, so you can identify which line is ringing based on the ringtone. For example, line 2 might have a different-pitched version of line 1's ringtone.\nMany corded phones, cordless phone bases, or cordless handsets without speakers have a tiny speaker called a piezoelectric speaker, or piezo for short. This type of speaker typically plays only monophonic tones/melodies, as polyphonic tones might not sound good. For corded or corded/cordless phones with line power as backup, a piezo is often used instead of the main speaker. Some phones with speakerphone/answering system use a piezo instead of the speaker for the ringer.")
    }
}

#Preview {
    RingtoneInfoView()
}
