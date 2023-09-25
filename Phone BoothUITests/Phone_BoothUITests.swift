//
//  Phone_BoothUITests.swift
//  Phone BoothUITests
//
//  Created by Tyler Sheft on 9/21/23.
//

import XCTest

final class Phone_BoothUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		app.buttons["AddPhoneButton"].firstMatch.click()
		let screenshot = app.windows.firstMatch.screenshot()
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
