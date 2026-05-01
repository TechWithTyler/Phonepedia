//
//  PhoneTimelineView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 5/1/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct PhoneTimelineView: View {

    // MARK: - Properties - Phones

    let phones: [Phone]

    var sortedPhones: [Phone] {
        return phones.sorted { $0.releaseYear < $1.releaseYear }
    }

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                if phones.isEmpty {
                    HStack {
                        Spacer()
                        ListEmptyView()
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
        ForEach(Array(sortedPhones.enumerated()), id: \.element.id) { index, phone in
            TimelineRowView(
                phone: phone,
                isLast: index == sortedPhones.count - 1
            )
        }
    }

}

// MARK: - Preview

#Preview {
    PhoneTimelineView(phones: [.mockPhone])
}
