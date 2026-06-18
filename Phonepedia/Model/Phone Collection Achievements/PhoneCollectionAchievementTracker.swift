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

    // The array of phones to check.
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

    // Years that phones were acquired in.
    var acquisitionYears: [Int] {
        // 1. Create an array of years.
        var years: [Int] = []
        // 2. For each phone in phones, add their acquisition years to the array.
        for phone in phones {
            let acquisitionYear = phone.acquisitionYear
            let replacesPhoneAcquiredInYear = phone.replacesPhoneAcquiredInYear
            if acquisitionYear > 0 {
                years.append(acquisitionYear)
            }
            if replacesPhoneAcquiredInYear > 0 {
                years.append(phone.replacesPhoneAcquiredInYear)
            }
        }
        // 3. Return the array.
        return years
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
            PhoneCollectionAchievement(id: "cordedAndCordless", title: "Get a Corded And a Cordless Phone", isUnlocked: hasCordedAndCordless),
            PhoneCollectionAchievement(id: "brandNew", title: "Get a Brand-New Phone", isUnlocked: hasBrandNew),
            PhoneCollectionAchievement(id: "releaseYear", title: "Get a Phone In Its Release Year", isUnlocked: gotInReleaseYear),
            PhoneCollectionAchievement(id: "multiHandset", title: "Get 2 or More Cordless Devices for a Phone", isUnlocked: got2OrMoreCordlessDevices),
            PhoneCollectionAchievement(id: "callBlockPreScreening", title: "Get a Phone With Call Block Pre-Screening", isUnlocked: hasCallBlockPreScreening),
            PhoneCollectionAchievement(id: "BTCellLinking", title: "Get a Phone With Bluetooth Cell Phone Linking", isUnlocked: hasBluetoothCellLinking),
            PhoneCollectionAchievement(id: "placeOnBasePowerBackup", title: "Get a Cordless Phone With Place-On-Base Power Backup", isUnlocked: hasPlaceOnBasePowerBackup),
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
            PhoneCollectionAchievement(id: "count200Handsets", title: "Get 200 Cordless Devices Across All Phones", isUnlocked: reachedCordlessDeviceCount(200)),
            PhoneCollectionAchievement(id: "acquired5PhonesInAYear", title: "Get 5 Phones In a Year", isUnlocked: reachedPhoneCountInAYear(5)),
            PhoneCollectionAchievement(id: "acquired10PhonesInAYear", title: "Get 10 Phones In a Year", isUnlocked: reachedPhoneCountInAYear(10))
        ]
    }

    // MARK: - Reached Count

    // Returns whether the phones array contains at least n phones.
    func reachedPhoneCount(_ n: Int) -> Bool {
        return phones.count >= n
    }

    // Returns whether n phones were acquired in at least one particular year.
    func reachedPhoneCountInAYear(_ n: Int) -> Bool {
        // 1. Create a dictionary to store the year and count, where the key is the year and the value is the number of times the year exists in the array.
        var yearCounts: [Int : Int] = [:]
        // 2. For each occurrence of the acquisition year in the array, add 1 for that year in the dictionary.
        for year in acquisitionYears {
            yearCounts[year, default: 0] += 1
        }
        // 3. Return whether the dictionary's values contains any number greater than or equal to n.
        return yearCounts.values.contains { $0 >= n }
    }

    // Returns whether the total number of cordless devices across all phones in the phones array is at least n.
    func reachedCordlessDeviceCount(_ n: Int) -> Bool {
        // 1. Create a variable to keep track of the total number of cordless devices.
        var totalCordlessDevices: Int = 0
        // 2. Loop through each phone in the phones array.
        for phone in phones {
            // 3. Add the phone's number of cordless devices to the total.
            totalCordlessDevices += phone.cordlessHandsetsIHave.count
        }
        // 4. Compare the total to n.
        return totalCordlessDevices >= n
    }

}
