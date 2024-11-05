//
//  HandsetActionsView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 9/9/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct HandsetActionsView: View {

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Handset

    @Bindable var handset: CordlessHandset

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Properties - Integers

    var handsetNumber: Int

    var body: some View {
        if let phone = handset.phone {
            Button {
                phone.cordlessHandsetsIHave.insert(handset.duplicate(), at: handsetNumber)
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

#Preview {
    HandsetActionsView( handset: CordlessHandset(brand: "Panasonic", model: "KX-TGUA40", mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0), handsetNumber: 1)
}
