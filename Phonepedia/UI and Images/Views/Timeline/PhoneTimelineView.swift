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

    // All phones.
    let phones: [Phone]

    // All phones, sorted from oldest release year to newest release year.
    var sortedPhones: [Phone] {
        return phones.sorted { $0.releaseYear < $1.releaseYear }
    }

    // The sortedPhones array, filtered to only include active phones.
    var activePhones: [Phone] {
        return sortedPhones.filter { $0.storageOrSetup <= 1 }
    }

    // The given array of phones returned as an array of index-phone pairs.
    var enumeratedPhones: [EnumeratedSequence<[Phone]>.Element] {
        // 1. Choose which phones array to use.
        let array = showOnlyActive ? activePhones : sortedPhones
        // 2. Enumerate through the array to get each phone and its index. In an enumerated sequence, the item comes after its index in the pair.
        let enumeration = array.enumerated()
        // 3. Convert the enumerated sequence (phone + index) to an array.
        let enumerationAsArray = Array(enumeration)
        // 4. Return the converted array.
        return enumerationAsArray
    }

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Horizontal Size Class

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    // MARK: - Properties - Integers

    // The index of the newest phone in the timeline, which determines where to stop the line.
    var indexOfNewestPhone: Int {
        // 1. Choose which phones array to use.
        let array = showOnlyActive ? activePhones : sortedPhones
        // 2. Subtract 1 from the number of phones to get the last index.
        return array.count - 1
    }

    // MARK: - Properties - Booleans

    // Whether only active phones should be shown.
    @State var showOnlyActive: Bool = false

    // Whether there are no phones to display.
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
            TimelineRowView(phone: phone, isLast: index == indexOfNewestPhone)
        }
    }

}

// MARK: - Preview

#Preview {
    PhoneTimelineView(phones: [.mockPhone])
}
