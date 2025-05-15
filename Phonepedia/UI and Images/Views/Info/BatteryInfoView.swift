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
• Battery packs with plugs are the most common for cordless phones, but the plugs have the tendency to break off of the wires that connect to the batteries in the pack. "AA" or "AAA" refers to the type of batteries used in the pack.
• Battery packs with contacts were common in some non-DECT phones, but aren't really used anymore today.
• Standard batteries (AA, AAA, or 9V) are the best option, since you can use any brand and they're readily available at many stores. Some cordless handsets have the ability to detect non-rechargeable batteries by detecting the voltage levels of the installed batteries, and prevents them from charging if they're non-rechargeable. This detection may not work properly depending on the amount of charge or the maximum voltage of the installed batteries. Corded-only phones with batteries but no AC power always take standard AA, AAA, or 9V batteries.
""")
    }
    
}

#Preview {
    BatteryInfoView()
}
