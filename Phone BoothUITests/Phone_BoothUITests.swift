//
//  Phone_BoothUITests.swift
//  Phone BoothUITests
//
//  Created by Tyler Sheft on 9/21/23.
//

import XCTest

final class Phone_BoothUITests: XCTestCase {

	var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
		app = XCUIApplication()
		// UI tests must launch the application that they test.
		app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddPhoneButton() throws {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		XCTAssert(app.buttons["AddPhoneButton"].exists)
		app.buttons["AddPhoneButton"].firstMatch.click()
			XCTAssert(self.app.outlines["PhonesList"].exists)
			self.app.outlines["PhonesList"].cells.firstMatch.click()
			XCTAssert(self.app.buttons["AddHandsetButton"].exists)
			self.app.buttons["AddHandsetButton"].firstMatch.click()
			XCTAssert(self.app.buttons["AddChargerButton"].exists)
			self.app.buttons["AddChargerButton"].firstMatch.click()
			let screenshot = self.app.windows.firstMatch.screenshot()
			// Get the Documents directory URL
			if let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
				// Create a filename for the screenshot (you can customize it)
				let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium)
				let filename = "\(self.name) Screenshot \(timestamp).png"
				// Construct the full URL for the screenshot in the Documents folder
				let screenshotURL = documentsURL.appending(path: filename)
				// Save the screenshot to the Documents folder
				do {
					try screenshot.pngRepresentation.write(to: screenshotURL)
					print("Screenshot saved to: \(screenshotURL.path)")
					NSWorkspace.shared.open(documentsURL)
					NSWorkspace.shared.open(screenshotURL)
				} catch {
					XCTFail("Failed to save screenshot: \(error.localizedDescription)")
				}
			} else {
				XCTFail("Failed to access the Documents folder.")
		}
	}

    func testLaunchPerformance() throws {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
    }
}
