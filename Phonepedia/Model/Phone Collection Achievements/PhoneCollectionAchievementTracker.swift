//
//  PhoneCollectionAchievementTracker.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/9/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import Foundation

// MARK: - Achievement Struct

struct PhoneCollectionAchievement: Identifiable, Equatable {

    // The ID of the achievement.
    let id: String

    // The title of the achievement.
    let title: String

    // Whether the achievement is unlocked.
    let isUnlocked: Bool

}

struct PhoneCollectionAchievementTracker {

    // MARK: - Properties - Phones

    let phones: [Phone]

    // MARK: - Properties - Booleans

    // Whether the phones array contains at least 1 corded and at least 1 cordless phone.
    var hasCordedAndCordless: Bool {
        let hasCordless = phones.contains { $0.isCordless }
        let hasCorded = phones.contains { !$0.isCordless }
        return hasCordless && hasCorded
    }

    // Whether the phones array contains at least 1 brand-new phone.
    var hasBrandNew: Bool {
        return phones.contains { $0.whereAcquired == 1 || $0.whereAcquired == 3 }
    }

    // Whether the phones array contains at least 1 phone that was acquired in its release year.
    var gotInReleaseYear: Bool {
        return phones.contains { $0.acquiredInYearOfRelease }
    }

    // Whether the phones array contains at least 1 phone with 2 or more cordless devices.
    var got2OrMoreCordlessDevices: Bool {
        return phones.contains { $0.cordlessHandsetsIHave.count >= 2 }
    }

    // Whether the phones array contains at least 1 phone with call block pre-screening.
    var hasCallBlockPreScreening: Bool {
        return phones.contains { $0.callBlockPreScreening >= 1 }
    }

    // Whether the phones array contains at least 1 phone with Bluetooth cell phone linking.
    var hasBluetoothCellLinking: Bool {
        return phones.contains { $0.baseBluetoothCellPhonesSupported >= 1 }
    }

    // Whether the phones array contains at least 1 cordless phone with place-on-base power backup.
    var hasPlaceOnBasePowerBackup: Bool {
        return phones.contains { $0.isCordless && !$0.hasCordedReceiver && $0.cordlessPowerBackupMode == 1 }
    }

    // MARK: - Properties - All Achievements

    // All possible achievements.
    var all: [PhoneCollectionAchievement] {
        return [
            // Events
            PhoneCollectionAchievement(id: "cordedAndCordless", title: "Get A Corded And A Cordless Phone", isUnlocked: hasCordedAndCordless),
            PhoneCollectionAchievement(id: "brandNew", title: "Get A Brand-New Phone", isUnlocked: hasBrandNew),
            PhoneCollectionAchievement(id: "releaseYear", title: "Get A Phone In Its Release Year", isUnlocked: gotInReleaseYear),
            PhoneCollectionAchievement(id: "multiHandset", title: "Get 2 Or More Cordless Devices For A Phone", isUnlocked: got2OrMoreCordlessDevices),
            PhoneCollectionAchievement(id: "callBlockPreScreening", title: "Get A Phone With Call Block Pre-Screening", isUnlocked: hasCallBlockPreScreening),
            PhoneCollectionAchievement(id: "BTCellLinking", title: "Get A Phone With Bluetooth Cell Phone Linking", isUnlocked: hasBluetoothCellLinking),
            PhoneCollectionAchievement(id: "placeOnBasePowerBackup", title: "Get A Cordless Phone With Place-On-Base Power Backup", isUnlocked: hasPlaceOnBasePowerBackup),
            // Phone Counts
            PhoneCollectionAchievement(id: "count10Phones", title: "Get 10 Phones", isUnlocked: reachedPhoneCount(10)),
            PhoneCollectionAchievement(id: "count20Phones", title: "Get 20 Phones", isUnlocked: reachedPhoneCount(20)),
            PhoneCollectionAchievement(id: "count50Phones", title: "Get 50 Phones", isUnlocked: reachedPhoneCount(50)),
            PhoneCollectionAchievement(id: "count100Phones", title: "Get 100 Phones", isUnlocked: reachedPhoneCount(100)),
            PhoneCollectionAchievement(id: "count150Phones", title: "Get 150 Phones", isUnlocked: reachedPhoneCount(150)),
            PhoneCollectionAchievement(id: "count200Phones", title: "Get 200 Phones", isUnlocked: reachedPhoneCount(200)),
            // Cordless Device Counts
            PhoneCollectionAchievement(id: "count10Handsets", title: "Get 10 Cordless Devices Across All Phones", isUnlocked: reachedCordlessDeviceCount(10)),
            PhoneCollectionAchievement(id: "count20Handsets", title: "Get 20 Cordless Devices Across All Phones", isUnlocked: reachedCordlessDeviceCount(20)),
            PhoneCollectionAchievement(id: "count50Handsets", title: "Get 50 Cordless Devices Across All Phones", isUnlocked: reachedCordlessDeviceCount(50)),
            PhoneCollectionAchievement(id: "count100Handsets", title: "Get 100 Cordless Devices Across All Phones", isUnlocked: reachedCordlessDeviceCount(100)),
            PhoneCollectionAchievement(id: "count150Handsets", title: "Get 150 Cordless Devices Across All Phones", isUnlocked: reachedCordlessDeviceCount(150)),
            PhoneCollectionAchievement(id: "count200Handsets", title: "Get 200 Cordless Devices Across All Phones", isUnlocked: reachedCordlessDeviceCount(200))
        ]
    }

    // MARK: - Reached Count

    // Returns whether the phones array contains at least n phones.
    func reachedPhoneCount(_ n: Int) -> Bool {
        return phones.count >= n
    }

    func reachedCordlessDeviceCount(_ n: Int) -> Bool {
        var totalCordlessDevices: Int = 0
        for phone in phones {
            totalCordlessDevices += phone.cordlessHandsetsIHave.count
        }
        return totalCordlessDevices >= n
    }

}
