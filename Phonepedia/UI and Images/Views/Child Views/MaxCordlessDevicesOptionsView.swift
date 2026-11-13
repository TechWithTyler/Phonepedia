//
//  MaxCordlessDevicesOptionsView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/13/26.
//  Copyright © 2026 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct MaxCordlessDevicesOptionsView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Properties - Integers

    // The value to set this phone's maximum number of cordless devices when switching from Unlimited to Limited.
    var safeMax: Int {
        // 1. Get the number of included cordless devices and the number of cordless device the user has added to this phone.
        let includedCount = phone.numberOfIncludedCordlessHandsets
        let userAddedCount = phone.cordlessHandsetsIHave.count
        // 2. Use the number of cordless devices the user has added to this phone if it's greater than the number of included cordless devices.
        return max(includedCount, userAddedCount)
    }

    private var limitedMaxBinding: Binding<Int> {
        Binding(
            get: {
                min(phone.maxCordlessHandsets, 10000)
            },
            set: {
                phone.maxCordlessHandsets = $0
            }
        )
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            Text("Maximum Number of Cordless Devices")
                .lineLimit(nil)
                HStack {
                    Button("Limited") {
                        phone.maxCordlessHandsets = safeMax
                    }
                    .tint(phone.maxCordlessHandsets < Int.max ? .accentColor.mix(with: .primary, by: 0.25) : .primary)
                    .bold(phone.maxCordlessHandsets < Int.max)
                    .underline(phone.maxCordlessHandsets < Int.max, color: .primary)
                    .padding(4)
#if !os(macOS)
                    .hoverEffect(.highlight)
#endif
                    .accessibilityConditionalTrait(.isSelected, condition: phone.maxCordlessHandsets == Int.max)
                    Button("Unlimited") {
                        phone.maxCordlessHandsets = Int.max
                    }
                    .tint(phone.maxCordlessHandsets == Int.max ? .accentColor.mix(with: .primary, by: 0.25) : .primary)
                    .bold(phone.maxCordlessHandsets == Int.max)
                    .underline(phone.maxCordlessHandsets == Int.max, color: .primary)
                    .padding(4)
#if !os(macOS)
                    .hoverEffect(.highlight)
#endif
                    .accessibilityConditionalTrait(.isSelected, condition: phone.maxCordlessHandsets == Int.max)
                }
                .animation(.linear, value: phone.maxCordlessHandsets)
                .buttonStyle(.borderless)
            if phone.maxCordlessHandsets < Int.max {
                FormNumericTextField("Up to", value: limitedMaxBinding, valueRange: safeMax...10000, step: 1, usesGroupingSeparator: true, singularSuffix: "Cordless Device", pluralSuffix: "Cordless Devices")
                    .animation(.linear, value: phone.maxCordlessHandsets == Int.max)
            }
        }
    }

}

#Preview {
    MaxCordlessDevicesOptionsView(phone: .mockPhone)
}
