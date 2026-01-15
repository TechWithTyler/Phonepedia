//
//  PhoneCollectionAchievements.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/9/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import Foundation

// MARK: - Achievement Struct

struct PhoneCollectionAchievement: Identifiable, Equatable {

    let id: String

    let title: String

    let isUnlocked: Bool

}

struct PhoneCollectionAchievements {

    // MARK: - Properties - Phones

    let phones: [Phone]

    // MARK: - Properties - Booleans

    var hasCordedAndCordless: Bool {
        let hasCordless = phones.contains { $0.isCordless }
        let hasCorded = phones.contains { !$0.isCordless }
        return hasCordless && hasCorded
    }

    var hasBrandNew: Bool {
        return phones.contains { $0.whereAcquired == 1 || $0.whereAcquired == 3 }
    }

    var gotInReleaseYear: Bool {
        return phones.contains { $0.acquiredInYearOfRelease }
    }

    // MARK: - Properties - All Achievements

    var all: [PhoneCollectionAchievement] {
        return [
            PhoneCollectionAchievement(id: "cordedAndCordless", title: "Get A Corded And A Cordless Phone", isUnlocked: hasCordedAndCordless),
            PhoneCollectionAchievement(id: "brandNew", title: "Get A Brand-New Phone", isUnlocked: hasBrandNew),
            PhoneCollectionAchievement(id: "releaseYear", title: "Get A Phone In Its Release Year", isUnlocked: gotInReleaseYear),
            PhoneCollectionAchievement(id: "count10", title: "Get 10 Phones", isUnlocked: reachedCount(10)),
            PhoneCollectionAchievement(id: "count20", title: "Get 20 Phones", isUnlocked: reachedCount(20)),
            PhoneCollectionAchievement(id: "count50", title: "Get 50 Phones", isUnlocked: reachedCount(50)),
            PhoneCollectionAchievement(id: "count100", title: "Get 100 Phones", isUnlocked: reachedCount(100)),
            PhoneCollectionAchievement(id: "count150", title: "Get 150 Phones", isUnlocked: reachedCount(150)),
            PhoneCollectionAchievement(id: "count200", title: "Get 200 Phones", isUnlocked: reachedCount(200))
        ]
    }

    // MARK: - Reached Count

    // Count milestones
    func reachedCount(_ n: Int) -> Bool { phones.count >= n }

}
