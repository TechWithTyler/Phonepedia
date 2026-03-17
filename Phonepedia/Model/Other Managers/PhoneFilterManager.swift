//
//  PhoneFilterManagerswift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/9/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import Foundation

class PhoneFilterManager {

    // MARK: - Criteria Struct

    struct Criteria: Equatable {

        // The current setting of the phone type filter.
        var type: String = allItemsFilterOptionTag

        // The current setting of the brand filter.
        var brand: String = allItemsFilterOptionTag

        // The current setting of the active status filter.
        var activeStatus: Int = 0

        // The current setting of the included cordless device number filter.
        var numberOfCordlessDevices: Int = 0

        // The current setting of the "has answering system" filter.
        var answeringSystem: Int = 0

        // The current setting of the "has Bluetooth cell linking" filter.
        var bluetoothCellLinking: Int = 0

        // Whether any filter is active.
        var isEnabled: Bool {
            return type != allItemsFilterOptionTag || activeStatus != 0 || brand != allItemsFilterOptionTag || numberOfCordlessDevices != 0 || answeringSystem != 0 || bluetoothCellLinking != 0
        }

        // Whether the selected type filter allows cordless device count filtering (i.e. type is all or cordless).
        var typeAllowsCordlessDeviceFilter: Bool {
            return type == Phone.PhoneType.cordless.rawValue.lowercased() || type == allItemsFilterOptionTag
        }

        // Whether the selected type filter isn't a Wi-Fi or cellular handset.
        var typeIsNotStandaloneWireless: Bool {
            return type != Phone.PhoneType.wiFiHandset.rawValue.lowercased() && type != Phone.PhoneType.cellularHandset.rawValue.lowercased()
        }

    }

    // MARK: - Brands

    // Returns all unique brands from the given phones, sorted alphabetically.
    static func allBrands(from phones: [Phone]) -> [String] {
        return Set(phones.map(\.brand)).sorted()
    }

    // MARK: - Filtering

    // This method applies all filters in sequence.
    static func filter(_ phones: [Phone], with criteria: Criteria) -> [Phone] {
        // 1. Create a property for the filtered phones array, starting with all phones.
        var filteredPhones = phones
        // 2. Filter by type.
        filteredPhones = filterByType(filteredPhones, type: criteria.type)
        // 3. Filter by active status.
        filteredPhones = filterByActiveStatus(filteredPhones, status: criteria.activeStatus)
        // 4. Filter by brand.
        filteredPhones = filterByBrand(filteredPhones, brand: criteria.brand)
        // 5. Filter by number of included cordless devices.
        if criteria.numberOfCordlessDevices != 0 && criteria.typeAllowsCordlessDeviceFilter {
            filteredPhones = filteredPhones.filter {
                $0.numberOfIncludedCordlessHandsets == criteria.numberOfCordlessDevices
            }
        }
        // 6. Filter by whether it has an answering system.
        if criteria.typeIsNotStandaloneWireless {
            filteredPhones = filterByAnsweringSystemPresence(filteredPhones, answeringSystem: criteria.answeringSystem)
            filteredPhones = filterByBluetoothCellLinkingPresence(filteredPhones, bluetoothCellLinking: criteria.bluetoothCellLinking)
        }
        // 7. Return the filtered phones array.
        return filteredPhones
    }

    // This method filters phones by type.
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

    // This method filters phones by active status.
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

    // This method filters phones by brand.
    private static func filterByBrand(_ phones: [Phone], brand: String) -> [Phone] {
        switch brand {
            // All
        case allItemsFilterOptionTag: return phones
            // Selected brand
        default: return phones.filter { $0.brand == brand }
        }
    }

    // This method filters phones by whether they have answering systems.
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

    // This method filters phones by whether they have Bluetooth cell phone linking.
    private static func filterByBluetoothCellLinkingPresence(_ phones: [Phone], bluetoothCellLinking: Int) -> [Phone] {
        switch bluetoothCellLinking {
            // With Bluetooth cell phone linking
        case 1: return phones.filter { $0.baseBluetoothCellPhonesSupported > 0 }
            // Without Bluetooth cell phone linking
        case 2: return phones.filter { $0.baseBluetoothCellPhonesSupported == 0
        }
            // All
        default: return phones
        }
    }

}
