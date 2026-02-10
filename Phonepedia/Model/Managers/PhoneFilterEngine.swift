//
//  PhoneFilterManagerswift
//  Phonepedia
//
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import Foundation

class PhoneFilterManager {

    // MARK: - Criteria Struct

    struct Criteria: Equatable {

        var type: String = allItemsFilterOptionTag

        var brand: String = allItemsFilterOptionTag

        var activeStatus: Int = 0

        var numberOfCordlessDevices: Int = 0

        var answeringSystem: Int = 0

        // Whether any filter is active.
        var isEnabled: Bool {
            type != allItemsFilterOptionTag
                || activeStatus != 0
                || brand != allItemsFilterOptionTag
                || numberOfCordlessDevices != 0
                || answeringSystem != 0
        }

        // Whether the selected type filter allows cordless device count filtering.
        var typeAllowsCordlessDeviceFilter: Bool {
            type == Phone.PhoneType.cordless.rawValue.lowercased()
                || type == allItemsFilterOptionTag
        }

        // Whether the selected type filter isn't a Wi-Fi or cellular handset.
        var typeIsNotStandaloneWireless: Bool {
            type != Phone.PhoneType.wiFiHandset.rawValue.lowercased()
                && type != Phone.PhoneType.cellularHandset.rawValue.lowercased()
        }

    }

    // MARK: - Filtering

    // Applies all filters in sequence.
    static func filter(_ phones: [Phone], with criteria: Criteria) -> [Phone] {
        var result = phones
        // 1. Filter by type.
        result = filterByType(result, type: criteria.type)
        // 2. Filter by active status.
        result = filterByActiveStatus(result, status: criteria.activeStatus)
        // 3. Filter by brand.
        result = filterByBrand(result, brand: criteria.brand)
        // 4. Filter by number of cordless devices.
        if criteria.numberOfCordlessDevices != 0 && criteria.typeAllowsCordlessDeviceFilter {
            result = result.filter {
                $0.numberOfIncludedCordlessHandsets == criteria.numberOfCordlessDevices
            }
        }
        // 5. Filter by whether it has an answering system.
        if criteria.typeIsNotStandaloneWireless {
            result = filterByAnsweringSystemPresence(result, answeringSystem: criteria.answeringSystem)
        }
        return result
    }

    // MARK: - Convenience

    // Returns all unique brands from the given phones, sorted alphabetically.
    static func allBrands(from phones: [Phone]) -> [String] {
        return Set(phones.map(\.brand)).sorted()
    }

    // MARK: - Private Helpers

    private static func filterByType(_ phones: [Phone], type: String) -> [Phone] {
        switch type {
        case Phone.PhoneType.cordless.rawValue.lowercased():
            // Cordless or corded/cordless
            return phones.filter { $0.isCordless || $0.isCordedCordless }
        case Phone.PhoneType.corded.rawValue.lowercased():
            // Corded
            return phones.filter { $0.numberOfIncludedCordlessHandsets == 0 && $0.basePhoneType == 0 }
        case Phone.PhoneType.wiFiHandset.rawValue.lowercased():
            // Wi-Fi handset
            return phones.filter { $0.basePhoneType == 1 }
        case Phone.PhoneType.cellularHandset.rawValue.lowercased():
            // Cellular handset
            return phones.filter { $0.basePhoneType == 2 }
        default:
            // All
            return phones
        }
    }

    private static func filterByActiveStatus(_ phones: [Phone], status: Int) -> [Phone] {
        switch status {
            // Active
        case 1: return phones.filter { $0.storageOrSetup <= 1 }
            // Inactive
        case 2: return phones.filter { $0.storageOrSetup > 1 }
            // All
        default: return phones
        }
    }

    private static func filterByBrand(_ phones: [Phone], brand: String) -> [Phone] {
        switch brand {
            // All
        case allItemsFilterOptionTag: return phones
            // Selected brand
        default: return phones.filter { $0.brand == brand }
        }
    }

    private static func filterByAnsweringSystemPresence(_ phones: [Phone], answeringSystem: Int) -> [Phone] {
        switch answeringSystem {
            // With answering system
        case 1: return phones.filter { $0.hasAnsweringSystem > 0 }
            // Without answering system
        case 2: return phones.filter { $0.hasAnsweringSystem == 0 }
            // All
        default: return phones
        }
    }

}
