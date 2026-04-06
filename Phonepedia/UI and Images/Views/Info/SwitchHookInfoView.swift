//
//  SwitchHookInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 4/6/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct SwitchHookInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("Most corded phones have a switch hook which presses, located on either the base (pressed by the receiver) or the receiver (pressed by the base). More advanced corded phones might have magnetic switch hooks, where magnets in the base and receiver trigger a magnetically-activated switch, called a reed switch. Some corded phones might use contacts like those found on cordless phones, instead of a switch hook. This is mostly seen on corded phones which are extensions of a cordless system, where placing the corded receiver on the cordless base registers the corded extension phone to the base.")
    }
}

// MARK: - Preview

#Preview {
    SwitchHookInfoView()
}
