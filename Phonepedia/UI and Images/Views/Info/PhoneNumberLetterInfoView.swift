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
        InfoText("The digits 2-9 on a phone's keypad or rotary dial have letters on them, which allow people to remember phone numbers by words they spell out (phonewords). For example, in the US phone testing number 1-631-791-8378, 8378 would spell TEST (8 has T, 3 has E, and 7 has S), so you can remember it as 1-631-791-TEST.\nAs Q and Z aren't commonly used in the English alphabet, 7 on a keypad/rotary dial didn't have the letter Q on it, and 9 didn't have the letter Z on it, until displays and the ability to enter names were introduced to phones and keypad-operated devices in general.\nAutomated phone services which prompt callers to press a specific digit to peform an action, often called IVR (Interactive Voice Response) systems, sometimes have commands laid out based on the corresponding letters (e.g. \"To delete this message, press 3.\" or \"Press the D key to delete this message.\"). This is not to be confused with the A, B, C, and D keys that are found on sone phone keypads which were used for special features of certain phone systems.")
    }
}

#Preview {
    PhoneNumberLetterInfoView()
}
