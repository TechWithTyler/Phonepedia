//
//  AnsweringSystemRemoteAccessInstructionsView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/19/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

import SwiftUI

struct AnsweringSystemRemoteAccessInstructionsView: View {

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Dialog Manager

    var phone: Phone

    // MARK: - Body

    var body: some View {
        NavigationStack {
            List {
                Text("During the greeting or recording a message, or when prompted for the remote access code:")
                if !phone.digitBeforeRemoteAccessCode.isEmpty {
                    Text("• Press \(phone.digitBeforeRemoteAccessCode).")
                }
                    Text("• Enter your \(phone.remoteAccessCodeLength)-digit remote access code.")
                    Text("• \(phone.remoteAccessVoiceMenu ? "Follow the voice menu" : "Refer to the manual for the required keys to press") to play your messages.")
            }
            .navigationTitle("Ans. Sys. Remote Acc. Instructions")
            .navigationSubtitle("For \(phone.brand) \(phone.model)")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
#if os(macOS)
        .frame(minWidth: 550, maxWidth: 550, minHeight: 350, maxHeight: 350)
#endif
    }
}

#Preview {
    AnsweringSystemRemoteAccessInstructionsView(phone: .mockPhone)
}
