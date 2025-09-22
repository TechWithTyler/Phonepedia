//
//  BatteryInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/8/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct BatteryInfoView: View {

    var body: some View {
        InfoText("""
• Battery packs with plugs are the most common for cordless phones, but the plugs have the tendency to break off of the wires that connect to the batteries in the pack. "AA" or "AAA" refer to the type of batteries used in the pack, and are rarely seen in the phone's documentation. It's mainly used for 3rd-parties that make replacement battery packs.
• Battery packs with contacts were common in some non-DECT phones, but aren't really used anymore today except for cordless phones which use lithium-ion batteries like those found in cell phones and other portable devices.
• Standard batteries (AA, AAA, or 9V for battery backup, AA or AAA for cordless handsets) are the best option, since you can use any brand and they're readily available at many stores. Some cordless handsets have the ability to detect non-rechargeable batteries by detecting the voltage levels of the installed batteries (rechargeable batteries have slightly less voltage than non-rechargeable batteries), and prevents them from charging if they're non-rechargeable. This detection may not work properly depending on the amount of charge or the maximum voltage of the installed batteries. Corded-only phones with batteries but no AC power always take standard AA, AAA, or 9V batteries.
""")
    }
    
}

#Preview {
    BatteryInfoView()
}
