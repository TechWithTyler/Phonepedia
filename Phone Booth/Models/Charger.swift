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

	init(phone: Phone? = nil) {
		self.phone = phone
	}

}
