//
//  PhoneBackstoryView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 4/8/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneBackstoryView: View {

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Phone

    var phone: Phone

    // MARK: - Properties - Doubles

    @AppStorage(UserDefaults.KeyNames.phoneDescriptionTextSize) var phoneDescriptionTextSize: Double = SATextViewIdealMinFontSize

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ScrollableText(phone.phoneDescription)
                .font(.system(size: phoneDescriptionTextSize))
                .isTextSelectable(true)
                .navigationTitle("\(phone.brand) \(phone.model) Backstory")
            .toolbar {
                ToolbarItem {
                    Button {
                        phoneDescriptionTextSize -= 1
                    } label: {
                        Label("Smaller", systemImage: "textformat.size.smaller")
#if os(macOS)
    .frame(minWidth: 50, minHeight: 15)
#endif
                    }
                    .disabled(phoneDescriptionTextSize == SATextViewIdealMinFontSize)
                    .labelStyle(.iconOnly)
                }
                ToolbarItem {
                    Button {
                        phoneDescriptionTextSize += 1
                    } label: {
                        Label("Larger", systemImage: "textformat.size.larger")
                        #if os(macOS)
                            .frame(minWidth: 50, minHeight: 15)
                        #endif
                    }
                    .disabled(phoneDescriptionTextSize == SATextViewIdealMaxFontSize)
                    .labelStyle(.iconOnly)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Close") {
                        dismiss()
                    }
                    .keyboardShortcut(.defaultAction)
                }
            }
        }
#if os(macOS)
        .frame(minWidth: 550, maxWidth: 550, minHeight: 350, maxHeight: 350)
#endif
    }

}

#Preview {
    @Previewable @State var phone = Phone(brand: "AT&T", model: "CLP99387")
    phone.phoneDescription = phoneDescriptionSampleText
    return PhoneBackstoryView(phone: phone)
        .modelContainer(for: Phone.self, inMemory: true)
}
