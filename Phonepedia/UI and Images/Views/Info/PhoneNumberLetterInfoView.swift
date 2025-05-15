//
//  PhoneNumberLetterInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/28/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneNumberLetterInfoView: View {
    var body: some View {
        InfoText("The digits 2-9 on a phone's keypad or rotary dial have letters on them, which allow people to remember phone numbers by words they spell out (phonewords). For example, the US rechargeable battery recycling service Call2Recycle's phone number is 1-800-8-BATTERY (1-800-822-8837), with the extra Y excluded (since that's outside of the 10 digits of the number). Phone numbers that intentionally spell out a phoneword, like this one, are called vanity numbers. Sometimes, the phoneword extends into the area code.\nAs Q and Z aren't commonly used in the English alphabet, 7 on a keypad/rotary dial didn't have the letter Q on it, and 9 didn't have the letter Z on it, until displays and the ability to enter names were introduced to phones and keypad-operated devices in general.\nAutomated phone services which prompt callers to press a specific digit to perform an action, often called IVR (Interactive Voice Response) systems, sometimes have commands laid out based on the corresponding letters (e.g. \"To delete this message, press 3.\" or \"Press the D key to delete this message.\"). This is not to be confused with the A, B, C, and D tones that are often used for signaling. In rare cases, automated phone services might ask callers to enter names by dialing the corresponding numbers, pressing each number until the desired letter on that number is heard or by simply dialing it like a phoneword, to enter the name. The latter method is often called T9 (text on 9 keys) dialing. For example, to enter the name \"John\" using the T9 method, dial 5646 and then, if necessary, follow the prompts to select the name, \"John\".\nOn phones with displays, names (e.g., for phonebook entries) are entered by pressing a number until the desired character on that number is displayed. Using the above example, press 5 until \"J\" is displayed, 6 until \"o\" is displayed, 4 until \"h\" is displayed, then 6 until \"n\" is displayed. Depending on the phone, switching between uppercase and lowercase letters is done by pressing star, pound, or another button, instead of cycling through uppercase then lowercase or vice versa. Pressing the number enough times will show the number itself. Symbols and spaces are typically entered by pressing 1, 0, star, and/or pound to cycle through available symbols or to enter a space. Refer to the phone's manual for its character mapping.")
    }
}

#Preview {
    PhoneNumberLetterInfoView()
}
