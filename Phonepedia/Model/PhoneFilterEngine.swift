//
//  PhoneFilterEngine.swift
//  Phonepedia
//
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import Foundation

enum PhoneFilterEngine {

    // MARK: - Filter Criteria

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

    // Applies all filters in sequence: type → active status → brand → cordless device count → answering system.
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

        // 5. Filter by answering system.
        if criteria.typeIsNotStandaloneWireless {
            result = filterByAnsweringSystem(result, answeringSystem: criteria.answeringSystem)
        }

        return result
    }

    // MARK: - Convenience

    // Returns all unique brands from the given phones, sorted alphabetically.
    static func allBrands(from phones: [Phone]) -> [String] {
        Set(phones.map(\.brand)).sorted()
    }

    // MARK: - Private Helpers

    private static func filterByType(_ phones: [Phone], type: String) -> [Phone] {
        switch type {
        case Phone.PhoneType.cordless.rawValue.lowercased():
            return phones.filter { $0.isCordless || $0.isCordedCordless }
        case Phone.PhoneType.corded.rawValue.lowercased():
            return phones.filter { $0.numberOfIncludedCordlessHandsets == 0 && $0.basePhoneType == 0 }
        case Phone.PhoneType.wiFiHandset.rawValue.lowercased():
            return phones.filter { $0.basePhoneType == 1 }
        case Phone.PhoneType.cellularHandset.rawValue.lowercased():
            return phones.filter { $0.basePhoneType == 2 }
        default:
            return phones
        }
    }

    private static func filterByActiveStatus(_ phones: [Phone], status: Int) -> [Phone] {
        switch status {
        case 1: return phones.filter { $0.storageOrSetup <= 1 }
        case 2: return phones.filter { $0.storageOrSetup > 1 }
        default: return phones
        }
    }

    private static func filterByBrand(_ phones: [Phone], brand: String) -> [Phone] {
        switch brand {
        case allItemsFilterOptionTag: return phones
        default: return phones.filter { $0.brand == brand }
        }
    }

    private static func filterByAnsweringSystem(_ phones: [Phone], answeringSystem: Int) -> [Phone] {
        switch answeringSystem {
        case 1: return phones.filter { $0.hasAnsweringSystem > 0 }
        case 2: return phones.filter { $0.hasAnsweringSystem == 0 }
        default: return phones
        }
    }

}
