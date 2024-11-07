//
//  PhoneNumberLetterInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/28/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneNumberLetterInfoView: View {
    var body: some View {
        InfoText("The digits 2-9 on a phone's keypad or rotary dial have letters on them, which allow people to remember phone numbers by words they spell out (phonewords). For example, the US rechargeable battery recycling service Call2Recycle's phone number is 1-800-8-BATTERY (1-800-822-8837), with the extra Y excluded. Sometimes, the phoneword extends into the area code.\nAs Q and Z aren't commonly used in the English alphabet, 7 on a keypad/rotary dial didn't have the letter Q on it, and 9 didn't have the letter Z on it, until displays and the ability to enter names were introduced to phones and keypad-operated devices in general.\nAutomated phone services which prompt callers to press a specific digit to perform an action, often called IVR (Interactive Voice Response) systems, sometimes have commands laid out based on the corresponding letters (e.g. \"To delete this message, press 3.\" or \"Press the D key to delete this message.\"). This is not to be confused with the A, B, C, and D keys that are found on sone phone keypads which were used for special features of certain phone systems. In rare cases, automated phone services might ask callers to enter names by dialing the corresponding numbers, pressing each number until the desired letter on that number is heard.")
    }
}

#Preview {
    PhoneNumberLetterInfoView()
}
