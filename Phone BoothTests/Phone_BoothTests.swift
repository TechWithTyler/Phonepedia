//
//  Phone_BoothTests.swift
//  Phone BoothTests
//
//  Created by Tyler Sheft on 9/6/23.
//

import XCTest
@testable import Phone_Booth

final class Phone_BoothTests: XCTestCase {

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

	func testBaseBluetoothCellPhonesSupportedChanged() {
		var phone = Phone(brand: "Panasonic", model: "KX-TGF975")
		phone.bluetoothPhonebookTransfers = 0
		let oldValue = 0
		let newValue = 1
		// Call the function
		PhoneDetailView(phone: phone).baseBluetoothCellPhonesSupportedChanged(oldValue: oldValue, newValue: newValue)
		// Assert that the phone's bluetoothPhonebookTransfers property has been updated
		XCTAssertEqual(phone.bluetoothPhonebookTransfers, 1)
	}


}
