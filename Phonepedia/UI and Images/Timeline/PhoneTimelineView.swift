//
//  PhoneTimelineView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 5/1/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct PhoneTimelineView: View {

    // MARK: - Properties - Phones

    let phones: [Phone]

    var sortedPhones: [Phone] {
        return phones.sorted { $0.releaseYear < $1.releaseYear }
    }

    var activePhones: [Phone] {
        return sortedPhones.filter { $0.storageOrSetup <= 1 }
    }

    var enumeratedPhones: [EnumeratedSequence<[Phone]>.Element] {
        let array = showOnlyActive ? activePhones : sortedPhones
        return Array(array.enumerated())
    }

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Horizontal Size Class

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    // MARK: - Properties - Integers

    var lastIndex: Int {
        let array = showOnlyActive ? activePhones : sortedPhones
        return array.count - 1
    }

    // MARK: - Properties - Booleans

    @State var showOnlyActive: Bool = false

    var noPhones: Bool {
        return showOnlyActive ? activePhones.isEmpty : sortedPhones.isEmpty
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack {
                Toggle("Show Only Active Phones", isOn: $showOnlyActive)
                    .toggleStyle(.stateLabelCheckbox(stateLabelPair: .yesNo))
                    .padding(.horizontal)
                if noPhones {
                    HStack {
                        Spacer()
                        NoPhonesView()
                        Spacer()
                    }
                } else {
                    if horizontalSizeClass == .compact {
                        ScrollView {
                            LazyVStack(alignment: .leading) {
                                timeline
                            }
                            .padding()
                        }
                    } else {
                        ScrollView(.horizontal) {
                            LazyHStack(alignment: .top) {
                                timeline
                            }
                            .padding()
                        }
                    }
                }
            }
                    .navigationTitle("Timeline")
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("OK") {
                                dismiss()
                            }
                            .keyboardShortcut(.defaultAction)
                        }
                    }
#if os(macOS)
                    .frame(minWidth: 550, minHeight: 100)
#endif
            }
    }

    // MARK: - Timeline

    @ViewBuilder
    var timeline: some View {
        ForEach(enumeratedPhones, id: \.element.id) { index, phone in
            TimelineRowView(phone: phone, isLast: index == lastIndex)
        }
    }

}

// MARK: - Preview

#Preview {
    PhoneTimelineView(phones: [.mockPhone])
}
