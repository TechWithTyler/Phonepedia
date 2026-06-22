//
//  TimelineRowView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 5/1/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct TimelineRowView: View {

    // MARK: - Properties - Phone

    let phone: Phone

    // MARK: - Properties - Strings

    var formattedReleaseYear: String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false
        let year = formatter.string(from: NSNumber(value: phone.releaseYear))!
        return year
    }

    // MARK: - Properties - Booleans

    let isLast: Bool

    // MARK: - Body

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack(alignment: .center, spacing: 0) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
                if !isLast {
                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(height: 2)
                        .frame(maxWidth: .infinity)
                }
            }
            LazyVStack(alignment: .center, spacing: 4) {
                Text(formattedReleaseYear)
                    .font(.headline)
                Text("Phone \(phone.actualPhoneNumberInCollection)")
                PhoneImage(phone: phone, displayMode: .thumbnail)
                Text(phone.brand)
                    .font(.body)
                Text(phone.model)
                    .font(.body)
            }
            .frame(width: 120)
            .accessibilityLabel("Phone \(phone.actualPhoneNumberInCollection), \(phone.brand) \(phone.model), released \(formattedReleaseYear)")
        }
        .padding(.horizontal, 8)
    }
}

// MARK: - Preview

#Preview {
    TimelineRowView(phone: .mockPhone, isLast: true)
}
