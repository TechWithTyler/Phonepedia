//
//  ProgrammingWithoutDisplayInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/22/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct ProgrammingWithoutDisplayInfoView: View {
    var body: some View {
        InfoText("To change settings on a phone without a display, for settings not changed by physical switches, the phone has a program button. Refer to the phone's manual or any instructions on the phone for how to change settings or store quick dial numbers.\nTypical programming sequence for speed dials: The program button (actual name varies) > enter number > the program or auto button (actual name varies) > the desired speed dial digit.\nTypical programming sequence for one-touch/memory dials: Program > enter number > the desired memory button.\nTo change settings, typically you press the program button followed by the auto button, then press a button that isn't a speed dial digit or one-touch dial button. For example, to change the dial mode when there's no physical switch for it, you might press the program button, then the auto button, then star for tone or pound for pulse.")
    }
}

#Preview {
    ProgrammingWithoutDisplayInfoView()
}
