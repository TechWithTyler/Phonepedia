//
//  PhoneCollectionAchievementsView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/8/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct PhoneCollectionAchievementsView: View {

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Phones

    // All phones in the catalog.
    var phones: [Phone]

    // MARK: - Properties - Booleans

    // Whether the phones array contains at least one corded phone and at least one cordless phone.
    var getCordedAndCordlessPhones: Bool {
        return !phones.filter({$0.isCordless}).isEmpty && !phones.filter({!$0.isCordless}).isEmpty
    }

    // Whether the phones array contains at least one phone purchased brand-new.
    var getABrandNewPhone: Bool {
        return phones.contains { phone in
            return phone.whereAcquired == 1 || phone.whereAcquired == 3
        }
    }

    // Whether the phones array contains at least one phone acquired in its release year.
    var gotAPhoneInYearOfRelease: Bool {
        return phones.contains { phone in
            return phone.acquiredInYearOfRelease
        }
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            List {
                PhoneCollectionAchievementRow(title: "Get A Brand-New Phone", condition: getABrandNewPhone)
                PhoneCollectionAchievementRow(title: "Got A Phone In Its Release Year", condition: gotAPhoneInYearOfRelease)
                PhoneCollectionAchievementRow(title: "Get 10 Phones", condition: phones.count >= 10)
                PhoneCollectionAchievementRow(title: "Get 20 Phones", condition: phones.count >= 20)
                PhoneCollectionAchievementRow(title: "Get 50 Phones", condition: phones.count >= 50)
                PhoneCollectionAchievementRow(title: "Get 100 Phones", condition: phones.count >= 100)
            }
            .navigationTitle("Achievements")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK") {
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

// MARK: - Preview

#Preview {
    PhoneCollectionAchievementsView(phones: [Phone(brand: "Panasonic", model: "KX-TG994SK")])
}
