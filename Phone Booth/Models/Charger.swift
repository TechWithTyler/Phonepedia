//
//  Charger.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/28/23.
//

import Foundation
import SwiftData

@Model
final class Charger {

	var phone: Phone?

	var color: String

	var chargingDirection: Int

	var chargeContactPlacement: Int

	var chargeContactMechanism: Int

	var hasRangeExtender: Bool

	init(phone: Phone? = nil) {
		self.phone = phone
		self.color = String()
		self.chargingDirection = 0
		self.chargeContactPlacement = 0
		self.chargeContactMechanism = 1
		self.hasRangeExtender = false
	}

}
