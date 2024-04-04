//
//  PhonepediaTests.swift
//  PhonepediaTests
//
//  Created by Tyler Sheft on 9/6/23.
//

import XCTest
@testable import Phonepedia

final class PhonepediaTests: XCTestCase {

	var phone: Phone?

	var phoneDetailView: PhoneDetailView?

	var handsetInfoDetailView: HandsetInfoDetailView?

	var handset: CordlessHandset?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		phone = Phone(brand: "Panasonic", model: "KX-TGF975")
		handset = CordlessHandset(brand: "Panasonic", model: "KX-TGFA97")
		phone?.cordlessHandsetsIHave.append(handset!)
		phoneDetailView = PhoneDetailView(phone: phone!)
		handsetInfoDetailView = HandsetInfoDetailView(handset: .constant(handset!), handsetNumber: 1)
		print((phone?.bluetoothPhonebookTransfers)!)
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

	func testHandsetCordlessDeviceTypeChanged() {
		handset?.fitsOnBase = true
		let oldValue = 0
		let newValue = 1
		// Call the function
		handset?.cordlessDeviceTypeChanged(oldValue: oldValue, newValue: newValue)
		// Assert that the phone's fitsOnBase property has been updated
		XCTAssertEqual(handset?.fitsOnBase, false)
	}

	func testHandsetCordlessDeviceTypeNotChanged() {
		handset?.fitsOnBase = true
		let oldValue = 0
		let newValue = 0
		// Call the function
		handset?.cordlessDeviceTypeChanged(oldValue: oldValue, newValue: newValue)
		// Assert that the phone's fitsOnBase property has not been updated
		XCTAssertEqual(handset?.fitsOnBase, true)
	}


}
