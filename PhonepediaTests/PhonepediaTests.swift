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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testFilterCriteriaIsEnabled_defaultsToFalse() {
        XCTAssertFalse(PhoneFilterManager.Criteria().isEnabled)
    }
    
    func testFilterCriteriaIsEnabled_brandFilterTurnsItOn() {
        let criteria = PhoneFilterManager.Criteria(brand: "AT&T")
        XCTAssertTrue(criteria.isEnabled)
    }
    
    func testAllBrands_returnsUniqueSortedBrands() {
        let phones = [
            makePhone(brand: "AT&T", model: "CL83207"),
            makePhone(brand: "AT&T", model: "BL108-2"),
            makePhone(brand: "Sony", model: "SPP-N1000"),
            makePhone(brand: "Panasonic", model: "KX-TGD862")
        ]
        XCTAssertEqual(PhoneFilterManager.allBrands(from: phones), ["AT&T", "Panasonic", "Sony"])
    }
    
    func testFilter_cordlessTypeAndCordlessDeviceCount_returnsOnlyMatchingCordlessPhones() {
        let twoHandsetPhone = makePhone(
            brand: "Panasonic",
            model: "KX-TG7642",
            numberOfIncludedCordlessHandsets: 2
        )
        let cordedCordlessPhone = makePhone(
            brand: "AT&T",
            model: "CL84207",
            numberOfIncludedCordlessHandsets: 2,
            hasCordedReceiver: true
        )
        let threeHandsetPhone = makePhone(
            brand: "Panasonic",
            model: "KX-TG7873",
            numberOfIncludedCordlessHandsets: 3
        )
        let cordedPhone = makePhone(
            brand: "AT&T",
            model: "213",
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
        XCTAssertEqual(filteredPhones.map(\.model), ["KX-TG7642", "CL84207"])
    }
    
    func testFilter_cordedType_ignoresCordlessDeviceCountFilter() {
        let firstCordedPhone = makePhone(
            brand: "Western Electric",
            model: "500",
            numberOfIncludedCordlessHandsets: 0
        )
        let secondCordedPhone = makePhone(
            brand: "AT&T",
            model: "230",
            numberOfIncludedCordlessHandsets: 0
        )
        let cordlessPhone = makePhone(
            brand: "Panasonic",
            model: "KX-TGF975",
            numberOfIncludedCordlessHandsets: 5
        )
        let criteria = PhoneFilterManager.Criteria(
            type: Phone.PhoneType.corded.rawValue.lowercased(),
            numberOfCordlessDevices: 2
        )
        let filteredPhones = PhoneFilterManager.filter(
            [firstCordedPhone, secondCordedPhone, cordlessPhone],
            with: criteria
        )
        XCTAssertEqual(filteredPhones.map(\.model), ["500", "230"])
    }
    
    func testFilter_wifiType_ignoresAnsweringSystemFilter() {
        let firstWiFiHandset = makePhone(
            brand: "Grandstream",
            model: "WP810",
            basePhoneType: 1,
            hasAnsweringSystem: 0,
            numberOfIncludedCordlessHandsets: 0
        )
        let secondWiFiHandset = makePhone(
            brand: "Cisco",
            model: "8821",
            basePhoneType: 1,
            hasAnsweringSystem: 0,
            numberOfIncludedCordlessHandsets: 0
        )
        let cordlessPhone = makePhone(
            brand: "Panasonic",
            model: "KX-TG5632",
            basePhoneType: 0,
            hasAnsweringSystem: 3,
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
        XCTAssertEqual(filteredPhones.map(\.model), ["WP810", "8821"])
    }

    func testFilter_activeStatus_returnsOnlyMatchingPhones() {
        let activePhone = makePhone(
            brand: "AT&T",
            model: "BL108-2",
            storageOrSetup: 1
        )
        let inactivePhone = makePhone(
            brand: "Panasonic",
            model: "KX-TGL463",
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
        XCTAssertEqual(filteredActivePhones.map(\.model), ["BL108-2"])
        XCTAssertEqual(filteredInactivePhones.map(\.model), ["KX-TGL463"])
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
