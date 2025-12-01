//
//  HandsetActionsView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 9/9/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct HandsetActionsView: View {

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Objects

    @Bindable var handset: CordlessHandset

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Body

    var body: some View {
        if let phone = handset.phone {
                Text("Assigned to phone \(phone.actualPhoneNumberInCollection) (\(phone.brand) \(phone.model))")
                Button {
                    dialogManager.handsetToReassign = handset
                    dialogManager.showingReassignHandset = true
                    dismiss()
                } label: {
                    Label("Reassign…", systemImage: "phone.arrow.right.fill")
                }
                if handset.maxBases > 1 {
                    InfoText("This cordless device can be registered to up to \(handset.maxBases) bases. Choose the phone that's its primary base.")
                }
            Button {
                phone.cordlessHandsetsIHave.insert(handset.duplicate(), at: handset.handsetNumber)
                dismiss()
            } label: {
                Label("Duplicate", systemImage: "doc.on.doc")
            }
            Button {
                dialogManager.showingDeleteHandset = true
                dialogManager.handsetToDelete = handset
                dismiss()
            } label: {
                Label("Delete…", systemImage: "trash")
#if !os(macOS)
                    .foregroundStyle(.red)
#endif
            }
        } else {
            Text("Actions unavailable")
        }
    }
}

// MARK: - Preview

#Preview {
    HandsetActionsView( handset: CordlessHandset(brand: "Panasonic", model: "KX-TGUA40", mainColorRed: 200, mainColorGreen: 200, mainColorBlue: 200, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0))
}
