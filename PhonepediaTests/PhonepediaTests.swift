//
//  PhonepediaTests.swift
//  PhonepediaTests
//
//  Created by Tyler Sheft on 9/6/23.
//

// MARK: - Imports

import XCTest
@testable import Phonepedia

final class PhonepediaTests: XCTestCase {
    
    func testFilterCriteriaIsEnabled_defaultsToFalse() {
        XCTAssertFalse(PhoneFilterManager.Criteria().isEnabled)
    }
    
    func testFilterCriteriaIsEnabled_brandFilterTurnsItOn() {
        let criteria = PhoneFilterManager.Criteria(brand: "AT&T")
        
        XCTAssertTrue(criteria.isEnabled)
    }
    
    func testAllBrands_returnsUniqueSortedBrands() {
        let phones = [
            makePhone(brand: "Sony", model: "A"),
            makePhone(brand: "AT&T", model: "B"),
            makePhone(brand: "Sony", model: "C"),
            makePhone(brand: "Panasonic", model: "D")
        ]
        
        XCTAssertEqual(PhoneFilterManager.allBrands(from: phones), ["AT&T", "Panasonic", "Sony"])
    }
    
    func testFilter_cordlessTypeAndCordlessDeviceCount_returnsOnlyMatchingCordlessPhones() {
        let twoHandsetPhone = makePhone(
            brand: "Panasonic",
            model: "KX-TG",
            numberOfIncludedCordlessHandsets: 2
        )
        let cordedCordlessPhone = makePhone(
            brand: "AT&T",
            model: "CL82413",
            numberOfIncludedCordlessHandsets: 2,
            hasCordedReceiver: true
        )
        let threeHandsetPhone = makePhone(
            brand: "Panasonic",
            model: "KX-TGA",
            numberOfIncludedCordlessHandsets: 3
        )
        let cordedPhone = makePhone(
            brand: "AT&T",
            model: "Trimline",
            numberOfIncludedCordlessHandsets: 0
        )
        let criteria = PhoneFilterManager.Criteria(
            type: Phone.PhoneType.cordless.rawValue.lowercased(),
            numberOfCordlessDevices: 2
        )
        
        let filteredPhones = PhoneFilterManager.filter(
            [twoHandsetPhone, cordedCordlessPhone, threeHandsetPhone, cordedPhone],
            with: criteria
        )
        
        XCTAssertEqual(filteredPhones.map(\.model), ["KX-TG", "CL82413"])
    }
    
    func testFilter_cordedType_ignoresCordlessDeviceCountFilter() {
        let firstCordedPhone = makePhone(
            brand: "Western Electric",
            model: "500",
            numberOfIncludedCordlessHandsets: 0
        )
        let secondCordedPhone = makePhone(
            brand: "AT&T",
            model: "Trimline",
            numberOfIncludedCordlessHandsets: 0
        )
        let cordlessPhone = makePhone(
            brand: "Panasonic",
            model: "KX-TG",
            numberOfIncludedCordlessHandsets: 2
        )
        let criteria = PhoneFilterManager.Criteria(
            type: Phone.PhoneType.corded.rawValue.lowercased(),
            numberOfCordlessDevices: 2
        )
        
        let filteredPhones = PhoneFilterManager.filter(
            [firstCordedPhone, secondCordedPhone, cordlessPhone],
            with: criteria
        )
        
        XCTAssertEqual(filteredPhones.map(\.model), ["500", "Trimline"])
    }
    
    func testFilter_wifiType_ignoresAnsweringSystemFilter() {
        let firstWiFiHandset = makePhone(
            brand: "Motorola",
            model: "WiFi One",
            basePhoneType: 1,
            hasAnsweringSystem: 0,
            numberOfIncludedCordlessHandsets: 0
        )
        let secondWiFiHandset = makePhone(
            brand: "Cisco",
            model: "WiFi Two",
            basePhoneType: 1,
            hasAnsweringSystem: 3,
            numberOfIncludedCordlessHandsets: 0
        )
        let cordlessPhone = makePhone(
            brand: "Panasonic",
            model: "Cordless",
            basePhoneType: 0,
            hasAnsweringSystem: 0,
            numberOfIncludedCordlessHandsets: 2
        )
        let criteria = PhoneFilterManager.Criteria(
            type: Phone.PhoneType.wiFiHandset.rawValue.lowercased(),
            answeringSystem: 2
        )
        
        let filteredPhones = PhoneFilterManager.filter(
            [firstWiFiHandset, secondWiFiHandset, cordlessPhone],
            with: criteria
        )
        
        XCTAssertEqual(filteredPhones.map(\.model), ["WiFi One", "WiFi Two"])
    }

    func testFilter_activeStatus_returnsOnlyMatchingPhones() {
        let activePhone = makePhone(
            brand: "AT&T",
            model: "Active",
            storageOrSetup: 1
        )
        let inactivePhone = makePhone(
            brand: "Panasonic",
            model: "Inactive",
            storageOrSetup: 2
        )
        let filteredActivePhones = PhoneFilterManager.filter(
            [activePhone, inactivePhone],
            with: PhoneFilterManager.Criteria(activeStatus: 1)
        )
        let filteredInactivePhones = PhoneFilterManager.filter(
            [activePhone, inactivePhone],
            with: PhoneFilterManager.Criteria(activeStatus: 2)
        )

        XCTAssertEqual(filteredActivePhones.map(\.model), ["Active"])
        XCTAssertEqual(filteredInactivePhones.map(\.model), ["Inactive"])
    }
    
    private func makePhone(
        brand: String,
        model: String,
        basePhoneType: Int = 0,
        hasAnsweringSystem: Int = 3,
        numberOfIncludedCordlessHandsets: Int = 0,
        storageOrSetup: Int = 0,
        hasCordedReceiver: Bool = false
    ) -> Phone {
        let phone = Phone(brand: brand, model: model)
        phone.basePhoneType = basePhoneType
        phone.hasAnsweringSystem = hasAnsweringSystem
        phone.numberOfIncludedCordlessHandsets = numberOfIncludedCordlessHandsets
        phone.storageOrSetup = storageOrSetup
        if hasCordedReceiver {
            phone.cordedReceiverMainColorAlpha = 1
        }
        return phone
    }
}
