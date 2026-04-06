//
//  CordedReceiverHookInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 4/6/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct CordedReceiverHookInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("The corded receiver hook holds it in place when the phone is wall-mounted, which prevents it from falling off the base. This is not to be confused with the switch hook, which is what tells the phone whether it's on or off-hook.\n• Fixed: The phone has a hook that slots into a hole on the corded receiver below the earpiece. On slim/wall phones where the switch hook is on the receiver instead of on the base, the switch hook is located directly below this hole and gets pressed by the hook on the base.\n• Flip/Rotate: The hook can be flipped or rotated so it sticks out when you want to mount the phone on the wall, or so it doesn't stick out when you don't want to mount it on the wall.\n• Removable: The phone has a removable hook which is inserted one way for desk use and another way for wall use. This is the most common type of corded receiver hook and has the risk of getting lost.")
    }
}

// MARK: - Preview

#Preview {
    CordedReceiverHookInfoView()
}
